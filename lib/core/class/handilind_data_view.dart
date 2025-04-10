import 'package:flutter/material.dart';

import 'status_request.dart';

class HandilingDatatView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandilingDatatView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.offLineFailure
            // ? const Center(child: CircularProgressIndicator())
            ? const Center(
                child: Dialog(
                  child: Text('StatusRequest.offLineFailure'),
                ),
              )
            : statusRequest == StatusRequest.failure
                ? const Center(
                    child: Dialog(
                      child: Text('StatusRequest.failure'),
                    ),
                  )
                : statusRequest == StatusRequest.serverFailure
                    ? const Center(
                        child: Dialog(
                          child: Text('StatusRequest.serverFailure'),
                        ),
                      )
                    : widget;
  }
}

class HandilingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandilingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: Center(child: CircularProgressIndicator()))
        : statusRequest == StatusRequest.offLineFailure
            ? const Center(child: Center(child: CircularProgressIndicator()))
            : statusRequest == StatusRequest.serverFailure
                ? const Center(
                    child: Center(child: CircularProgressIndicator()))
                : widget;
  }
}
