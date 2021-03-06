import 'dart:io';
import 'dart:typed_data';

import 'package:cadastro_projeto_requerimento/app/control/ProjectControl.dart';
import 'package:cadastro_projeto_requerimento/app/models/Project.dart';
import 'package:cadastro_projeto_requerimento/app/models/Requirement.dart';
import 'package:cadastro_projeto_requerimento/app/util/VDate.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_form_field/select_form_field.dart';

class RequirementForm extends StatelessWidget {
  RequirementForm({required this.ref_project, this.requirement});

  int ref_project;
  Requirement? requirement;

  @override
  Widget build(BuildContext context) {
    return RequirementFormDinamic(
        ref_project: ref_project, requirement: requirement);
  }
}

class RequirementFormDinamic extends StatefulWidget {
  RequirementFormDinamic({required this.ref_project, this.requirement});

  int ref_project;
  Requirement? requirement;

  @override
  State<RequirementFormDinamic> createState() => _RequirementFormDinamic(
      ref_project: ref_project, requirementEdit: requirement);
}

class _RequirementFormDinamic extends State<RequirementFormDinamic> {
  // This widget is the root of your application.
  _RequirementFormDinamic({required this.ref_project, this.requirementEdit});

  final TextEditingController con_desciption = TextEditingController();
  final TextEditingController con_tp_requirement = TextEditingController();
  String? con_dt_register;
  final TextEditingController con_dt_end = TextEditingController();
  final TextEditingController con_priority = TextEditingController();
  final TextEditingController con_level_complexity = TextEditingController();
  final TextEditingController con_time_work_estemeed = TextEditingController();

  Requirement? requirementEdit;

  int ref_project;
  Project? project;

  Position? _currentPosition;
  String? _currentAddress;
  bool isLoadingLocation = false;

  RequirementHelper requirementHelper = RequirementHelper();
  ProjectHelper projectHelper = ProjectHelper();

  File? file;
  File? file2;

  @override
  void initState() {
    if (requirementEdit?.id != null) {
      onLoad(requirementEdit!);
    }
    projectHelper.getProject(ref_project).then((value) => project = value);

    super.initState();
  }

  void pickFile(ImageSource source) async {
    final result = await ImagePicker().pickImage(source: source);

    if (result == null) return;

    final newFile = File(result.path);

    setState(() {
      file = newFile;
    });
  }

  void pickFile2(ImageSource source) async {
    final result = await ImagePicker().pickImage(source: source);

    if (result == null) return;

    final newFile = File(result.path);

    setState(() {
      file2 = newFile;
    });
  }

  void onLoad(Requirement requirement) {
    setState(() {
      con_desciption.text = requirement.description!;
      con_dt_end.text = requirement.dt_end!;
      con_time_work_estemeed.text = requirement.time_work_estemeed!;
      con_tp_requirement.text = requirement.tp_requirement!;
      con_priority.text = requirement.priority!;
      con_level_complexity.text = requirement.level_complexity!;

      (requirement.dt_register != null)
          ? con_dt_register = requirement.dt_register
          : VDate.ConvertDatetimeInString(DateTime.now());

      (requirement.img1 != null) ? file = File(requirement.img1!) : null;
      (requirement.img2 != null) ? file2 = File(requirement.img2!) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de requisitos'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 158, 156, 156),
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: con_desciption,
                              decoration: InputDecoration(
                                label: const Text('Descri????o'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SelectFormField(
                                controller: con_tp_requirement,
                                type: SelectFormFieldType.dropdown,
                                icon: const Icon(Icons.arrow_drop_down),
                                labelText: 'Tipo',
                                items: getItemsType(),
                                onChanged: (val) =>
                                    {con_tp_requirement.text = val},
                                onSaved: (val) =>
                                    {con_tp_requirement.text = val!},
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  label: const Text('Tipo'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              controller: con_dt_end,
                              decoration: InputDecoration(
                                label: const Text('Data Final'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SelectFormField(
                                controller: con_priority,
                                type: SelectFormFieldType.dropdown,
                                icon: const Icon(Icons.arrow_drop_down),
                                labelText: 'Prioridade',
                                items: getItems(),
                                onChanged: (val) => {con_priority.text = val},
                                onSaved: (val) => {con_priority.text = val!},
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  label: const Text('Prioridade'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 80,
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SelectFormField(
                                controller: con_level_complexity,
                                type: SelectFormFieldType.dropdown,
                                icon: const Icon(Icons.arrow_drop_down),
                                labelText: 'N??vel de complexidade',
                                items: getItems(),
                                onChanged: (val) =>
                                    {con_level_complexity.text = val},
                                onSaved: (val) =>
                                    {con_level_complexity.text = val!},
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  label: const Text('N??vel de complexidade'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: con_time_work_estemeed,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label: const Text(
                                    'Tempo estimado de trabalho(Minutos)'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    height: 200,
                                    width: 150,
                                    margin: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (file == null)
                                              ? const SizedBox(height: 150)
                                              : Center(
                                                  child: Image.file(
                                                    file!,
                                                    width: 140,
                                                    height: 150,
                                                  ),
                                                ),
                                          ElevatedButton(
                                              onPressed: () {
                                                showFileDialog(context, 1);
                                              },
                                              child: const Text('Imagem 1')),
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 200,
                                  width: 150,
                                  margin: const EdgeInsets.all(2),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        (file2 == null)
                                            ? const SizedBox(height: 150)
                                            : Center(
                                                child: Image.file(
                                                  file2!,
                                                  width: 140,
                                                  height: 150,
                                                ),
                                              ),
                                        ElevatedButton(
                                            onPressed: () {
                                              showFileDialog(context, 2);
                                              // pickFile2(ImageSource.camera);
                                            },
                                            child: const Text('Imagem 2')),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(16),
                      height: 50,
                      width: 150,
                      child: Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff00d7f3),
                                    padding: const EdgeInsets.all(15),
                                  ),
                                  child: const Text('Salvar'),
                                  onPressed: () {
                                    onSave();
                                  })))),
                  const SizedBox(height: 25),
                  Center(
                    child: (isLoadingLocation == true)
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              _currentAddress ?? '',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      height: 50,
                      width: 150,
                      child: Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 40, 228, 102),
                                    padding: const EdgeInsets.all(15),
                                  ),
                                  child: const Text('Ver localiza????o'),
                                  onPressed: () {
                                    initLocation();
                                  })))),
                ]))));
  }

  void onSave() {
    try {
      String desciption =
          (con_desciption.text != null) ? con_desciption.text : '';
      String dt_end = (con_dt_end.text != null) ? con_dt_end.text : '';
      String time_work_estemeed = (con_time_work_estemeed.text != null)
          ? con_time_work_estemeed.text
          : '';
      String tp_requirement =
          (con_tp_requirement.text != null) ? con_tp_requirement.text : '';
      String level_complexity =
          (con_level_complexity.text != null) ? con_level_complexity.text : '';
      String priority =
          (con_priority.text != null) ? con_level_complexity.text : '';
      String? dt_register = (con_dt_register != null)
          ? con_dt_register
          : VDate.ConvertDatetimeInString(DateTime.now());

      // new atributes
      String? pos_geo = '';
      String? img1 = (file?.path != null) ? file!.path : '';
      String? img2 = (file2?.path != null) ? file2!.path : '';

      Requirement objRequirement = Requirement();

      objRequirement.description = desciption;
      objRequirement.dt_end = dt_end;
      objRequirement.time_work_estemeed = time_work_estemeed;
      objRequirement.tp_requirement = tp_requirement;
      objRequirement.level_complexity = level_complexity;
      objRequirement.priority = con_priority.text;
      objRequirement.dt_register = dt_register;
      objRequirement.ref_project = ref_project;

      // new atributes
      objRequirement.pos_geo = pos_geo;
      objRequirement.img1 = img1;
      objRequirement.img2 = img2;

      if (requirementEdit?.id != null) {
        objRequirement.id = requirementEdit!.id;
        objRequirement.dt_register = requirementEdit!.dt_register;
        requirementHelper.updateRequirement(objRequirement);
      } else {
        requirementHelper.saveRequirement(objRequirement);
      }

      returnProjectControl();
    } catch (error) {
      throw Exception(error);
    }
  }

  void returnProjectControl() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectControl(edit_project: project!),
      ),
    );
  }

  List<Map<String, dynamic>> getItems() {
    final List<Map<String, dynamic>> _items = [
      {
        'value': 'Alto',
        'label': 'Alto',
        'icon': const Icon(Icons.circle),
      },
      {
        'value': 'Medio',
        'label': 'Medio',
        'icon': const Icon(Icons.circle),
      },
      {
        'value': 'Baixo',
        'label': 'Baixo',
        'icon': const Icon(Icons.circle),
      },
    ];
    return _items;
  }

  List<Map<String, dynamic>> getItemsType() {
    final List<Map<String, dynamic>> _items = [
      {
        'value': 'Funcional',
        'label': 'Funcional',
        'icon': const Icon(Icons.circle),
      },
      {
        'value': 'N??o funcional',
        'label': 'N??o funcional',
        'icon': const Icon(Icons.circle),
      },
    ];
    return _items;
  }

  _getAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.street}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  void initLocation() async {
    setState(() {
      isLoadingLocation = true;
    });

    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddress();
        isLoadingLocation = false;
      });
    }).catchError((e) {
      print(e);
    });
  }

  showFileDialog(BuildContext context, int index) {
    Widget voltarButton = ElevatedButton(
      child: const Text("Voltar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget fileButton = ElevatedButton(
      child: const Text("Galeria"),
      onPressed: () {
        (index == 1)
            ? pickFile(ImageSource.gallery)
            : pickFile2(ImageSource.gallery);

        Navigator.pop(context);
      },
    );

    Widget cameraButton = ElevatedButton(
      child: const Text("C??mera"),
      onPressed: () {
        (index == 1)
            ? pickFile(ImageSource.camera)
            : pickFile2(ImageSource.camera);

        Navigator.pop(context);
      },
    );
    // configura o Dialog
    AlertDialog alerta = AlertDialog(
      title: const Text("Info"),
      content: const Text('Selecione como quer importar a imagem'),
      actions: [voltarButton, fileButton, cameraButton],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
