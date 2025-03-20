import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monetra/bloc/host/host_event.dart';
import 'package:monetra/bloc/host/host_state.dart';
import 'package:monetra/models/host.dart';
import 'package:dio/dio.dart';

class HostBloc extends Bloc<HostEvent, HostState> {
  HostBloc() : super(HostInitial()) {
    on<FetchHosts>(_onFetchHosts);

    on<CreateHost>(
      (event, emit) async {
        try {
          final response = await Dio().post(
            "http://192.168.180.60/zabbix/api_jsonrpc.php",
            data: {
              "jsonrpc": "2.0",
              "method": "host.create",
              "params": {
                "host": event.hostName,
                "interfaces": [
                  {
                    "type": 1,
                    "main": 1,
                    "useip": event.connectionType == "IP" ? 1 : 0,
                    "ip": event.connectionType == "IP" ? event.ipAddress : "",
                    "dns": event.connectionType == "DNS" ? event.ipAddress : "",
                    "port": event.port
                  }
                ],
                "groups": [
                  {"groupid": event.groupId}
                ],
                "templates": [
                  {"templateid": event.templateId}
                ]
              },
              "auth":
                  "a6c41095c2aa33deac930f55d42503c20c307c5c1d0728959ac46c2aaf83e8e0",
              "id": 1
            },
            options: Options(
              headers: {
                "Content-type": "application/json",
              },
            ),
          );
          log("Response API Status Code: ${response.statusCode}");
          log("Response API Data: ${response.data}");

          if (response.statusCode == 200 && response.data != null) {
            String hostId = response.data['result']['hostids'][0];
            log("Successfully created host: $hostId");

            // add host to firestore
            await FirebaseFirestore.instance
                .collection("hosts")
                .doc(hostId)
                .set({
              "host": event.hostName,
              "hostId": hostId,
              "ip": event.connectionType == "IP" ? event.ipAddress : "",
              "icmpPing": false,
              "timestamp": FieldValue.serverTimestamp(),
            });

            emit(HostAdded());
            log("Host ${event.hostName} was successfully created.");
          } else if (response.data.containsKey("error")) {
            log("Error message: ${response.data["error"]["data"]}");
            throw Exception(response.data["error"]["data"]);
          } else {
            throw Exception("Failed to receive response from server.");
          }
        } catch (e) {
          emit(HostError("Failed to add host: ${e.toString()}"));
          log(e.toString());
        }
      },
    );

    on<DeleteHost>((event, emit) async {
      try {
        final response = await Dio().post(
          "http://192.168.180.60/zabbix/api_jsonrpc.php",
          data: {
            "jsonrpc": "2.0",
            "method": "host.delete",
            "params": [event.hostId],
            "auth":
                "a6c41095c2aa33deac930f55d42503c20c307c5c1d0728959ac46c2aaf83e8e0",
            "id": 1
          },
          options: Options(
            headers: {"Content-Type": "application/json"},
          ),
        );

        if (response.statusCode == 200 && response.data != null) {
          await FirebaseFirestore.instance
              .collection("hosts")
              .doc(event.hostId)
              .delete();
          emit(HostDelected());
          log("Successfully deleted host: ${event.hostId}");
        } else if (response.data.containsKey("error")) {
          log("Error message: ${response.data["error"]["data"]}");
          emit(HostError("Error message: ${response.data["error"]["data"]}"));
        } else {
          emit(HostError("Failed to delete host"));
        }
      } catch (e) {
        emit(HostError("Failed to delete host: ${e.toString()}"));
        log(e.toString());
      }
    });
  }
}

Future<void> _onFetchHosts(FetchHosts event, Emitter<HostState> emit) async {
  emit(HostLoading());

  try {
    var response = await Dio().post(
      "http://192.168.180.60/zabbix/api_jsonrpc.php",
      data: {
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
          "output": ["hostid", "host"],
          "selectInterfaces": ["ip"],
          "selectItems": ["itemid", "name", "key_", "lastvalue"]
        },
        "auth":
            "a6c41095c2aa33deac930f55d42503c20c307c5c1d0728959ac46c2aaf83e8e0",
        "id": 1
      },
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      List<dynamic> hostsJson = response.data['result'];
      log("request success");

      List<Host> hosts = hostsJson
          .where((json) =>
              json["hostid"] != "10084" && json["hostid"] != "10656") // Filter
          .map((json) => Host.fromJson(json))
          .toList();

      emit(HostLoaded(hosts));
      await _saveHostsToFirestore(hosts);
    } else {
      emit(HostError("Gagal mengambil data dari API"));
    }
  } catch (e) {
    log("error $e");
    emit(HostError("Terjadi kesalahan: ${e.toString()}"));
  }
}

Future<void> _saveHostsToFirestore(List<Host> hostsFromAPI) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference hostsCollection = firestore.collection('hosts');

    QuerySnapshot snapshot = await hostsCollection.get();
    List<String> existingHostIds = snapshot.docs.map((doc) => doc.id).toList();

    List<String> newHostIds = hostsFromAPI.map((host) => host.hostId).toList();

    for (String oldHostId in existingHostIds) {
      if (!newHostIds.contains(oldHostId)) {
        await hostsCollection.doc(oldHostId).delete();
        log("Host with ID $oldHostId was removed from Firestore because it does not exist in the API.");
      }
    }

    // Simpan/update data baru dari API
    for (Host host in hostsFromAPI) {
      await hostsCollection.doc(host.hostId).set({
        'hostId': host.hostId,
        'host': host.host,
        'ip': host.ip,
        'icmpPing': host.icmpPing,
        'timestamp': FieldValue.serverTimestamp(),
      });
      log("The hostId record ${host.hostId} was successfully updated in Firestore.");
    }
  } catch (e) {
    log("Error saving to Firestore: $e");
  }
}
