import 'package:flutter/material.dart';

class SetFolderIconViewer extends StatefulWidget {
  const SetFolderIconViewer({super.key});

  @override
  State<SetFolderIconViewer> createState() => _SetFolderIconViewerState();
}

class _SetFolderIconViewerState extends State<SetFolderIconViewer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: false, 
                onChanged: (value) {
                
                },
              ),
              const Text("Make icon portable"),
            ],
          ),
          FractionallySizedBox(
            widthFactor: 0.3,
            child: ElevatedButton(
              onPressed: () {
                
              }, 
              child: const Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_outlined),
                  Text("Set folder icon"),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.25,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ElevatedButton(
                onPressed: () {
                  
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.remove_outlined),
                    Text("Remove folder icon"),
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}