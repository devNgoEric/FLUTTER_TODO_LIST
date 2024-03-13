// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoadingModal extends StatefulWidget {
  final isDone;
  const LoadingModal({super.key, required this.isDone});

  @override
  State<LoadingModal> createState() => _LoadingModalState();
}

class _LoadingModalState extends State<LoadingModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black12,
      child: Center(
        child: Container(
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isDone ? Colors.green : Colors.deepPurple[500]
            ),
            child:  Center(
              child:  widget.isDone ? Icon(Icons.done, size: 40, color: Colors.white) : CircularProgressIndicator( color: Colors.white ),
            ),
          ),
      ),
    );
  }
}
