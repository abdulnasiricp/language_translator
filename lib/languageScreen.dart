// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: sized_box_for_whitespace, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';

class LangTranslator extends StatefulWidget {
  const LangTranslator({super.key});

  @override
  State<LangTranslator> createState() => _LangTranslatorState();
}

class _LangTranslatorState extends State<LangTranslator> {
 

  List<String> languages = [
    "Bengali",
    "English",
    "Hindi",
    "Japanese",
    "Pashto",
    "Punjabi",
    "Turkish",
    "Urdu",
    "Arabic"
  ];

  var originLanguage = 'From';
  var distinationLanguage = 'To';
  var result = '';
  TextEditingController languageController = TextEditingController();

 

  void trans(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();

    var traslation = await translator.translate(input, from: src, to: dest);
    setState(() {
      result = traslation.text.toString();
    });

    if (src == '--' || dest == '--') {
      setState(() { 
        result = 'Fail to translate';
      });
    }

  
  }

  String getlanguagecode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Urdu') {
      return 'ur';
    } 
     else if (language == 'Bengali') {
      return 'bn';
    }
     else if (language == 'Japanese') {
      return 'ja';
    }
    else if (language == 'Punjabi') {
      return 'pa';
    }
    else if (language == 'Turkish') {
      return 'tr';
    }
    else if (language == 'Arabic') {
      return 'ar';
    }
     else if (language == 'Pashto') {
      return 'ps';
    }else if (language == 'Hindi') {
      return 'hi';
    } else {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Language Translator'),
          centerTitle: true,
          backgroundColor: Colors.green[700],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  controller: languageController,
                  decoration: InputDecoration(
                    hintText: 'Text',
                    labelText: 'Please enter your text',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 40,
                      width: 140,
                      child: DropdownButton(
                        focusColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Colors.white,
                        dropdownColor: Colors.white,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: Text(
                          originLanguage,
                          style: const TextStyle(color: Colors.white),
                        ),
                        items: languages.map((String dropdownStringItem) {
                          return DropdownMenuItem(
                              value: dropdownStringItem,
                              child: Text(dropdownStringItem));
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            originLanguage = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.change_circle,
                    color: Colors.blue,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 40,
                      width: 140,
                      child: DropdownButton(
                        focusColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Colors.white,
                        dropdownColor: Colors.white,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: Text(
                          distinationLanguage,
                          style: const TextStyle(color: Colors.white),
                        ),
                        items: languages.map((String dropdownStringItem) {
                          return DropdownMenuItem(
                              value: dropdownStringItem,
                              child: Text(dropdownStringItem));
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            distinationLanguage = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  onPressed: () {
                    trans(
                        getlanguagecode(originLanguage),
                        getlanguagecode(distinationLanguage),
                        languageController.text.toString());
                        
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green[700])),
                  child: const Text('Translate'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                highlightColor: Colors.blue.withOpacity(0.3),
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: result));
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  size: 20,
                                )),
                          ),
                          Text(result.toString()),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
