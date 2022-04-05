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

  FilePickerResult? result;
  PlatformFile? file;
  String? file_path;

  FilePickerResult? result2;
  PlatformFile? file2;
  String? file2_path;

  File? edit_file1;
  File? edit_file2;

  @override
  void initState() {
    if (requirementEdit?.id != null) {
      onLoad(requirementEdit!);
    }
    projectHelper.getProject(ref_project).then((value) => project = value);

    super.initState();
  }

  void pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;

    file = result!.files.first;

    setState(() {});
  }

  void pickFile2() async {
    result2 = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result2 == null) return;

    file2 = result2!.files.first;

    setState(() {});
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

      (requirement.img1 != null) ? file_path = requirement.img1 : null;
      (requirement.img1 != null)
          ? edit_file1 = File(requirement.img1.toString())
          : null;

      (requirement.img2 != null) ? file2_path = requirement.img2 : null;
      (requirement.img2 != null)
          ? edit_file2 = File(requirement.img2.toString())
          : null;
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
                                label: const Text('Descrição'),
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
                                icon: Icon(Icons.arrow_drop_down),
                                labelText: 'Tipo',
                                items: getItemsType(),
                                onChanged: (val) =>
                                    {con_tp_requirement.text = val},
                                onSaved: (val) =>
                                    {con_tp_requirement.text = val!},
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  label: Text('Tipo'),
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
                                  // filled: true,
                                  // fillColor: Colors.white,
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
                                icon: Icon(Icons.arrow_drop_down),
                                labelText: 'Prioridade',
                                items: getItems(),
                                onChanged: (val) => {con_priority.text = val},
                                onSaved: (val) => {con_priority.text = val!},
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
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
                                  // filled: true,
                                  // fillColor: Colors.white,
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
                                labelText: 'Nível de complexidade',
                                items: getItems(),
                                onChanged: (val) =>
                                    {con_level_complexity.text = val},
                                onSaved: (val) =>
                                    {con_level_complexity.text = val!},
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  label: const Text('Nível de complexidade'),
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
                                  // filled: true,
                                  // fillColor: Colors.white,
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
                                          (file == null && file_path == null)
                                              ? const SizedBox(height: 150)
                                              : (file_path != null)
                                                  ? Center(
                                                      child: Image.file(
                                                        edit_file1!,
                                                        width: 140,
                                                        height: 150,
                                                      ),
                                                    )
                                                  : Center(
                                                      child: Image.file(
                                                        File(file!.path
                                                            .toString()),
                                                        width: 140,
                                                        height: 150,
                                                      ),
                                                    ),
                                          ElevatedButton(
                                              onPressed: () {
                                                pickFile();
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
                                        (file2 == null && file2_path == null)
                                            ? const SizedBox(height: 150)
                                            : (file2_path != null)
                                                ? Center(
                                                    child: Image.file(
                                                      edit_file2!,
                                                      width: 140,
                                                      height: 150,
                                                    ),
                                                  )
                                                : Center(
                                                    child: Image.file(
                                                      File(file2!.path
                                                          .toString()),
                                                      width: 140,
                                                      height: 150,
                                                    ),
                                                  ),
                                        ElevatedButton(
                                            onPressed: () {
                                              pickFile2();
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
                                  child: const Text('Ver localização'),
                                  onPressed: () {
                                    initLocation();
                                  })))),
                ]))));
  }

  void onSave() {
    try {
      String desciption = con_desciption.text;
      String dt_end = con_dt_end.text;
      String time_work_estemeed = con_time_work_estemeed.text;
      String tp_requirement = con_tp_requirement.text;
      String level_complexity = con_level_complexity.text;
      String priority = con_priority.text;
      String? dt_register = (con_dt_register != null)
          ? con_dt_register
          : VDate.ConvertDatetimeInString(DateTime.now());

      // new atributes
      String? pos_geo = '';
      String? img1 = (file?.path.toString() != null)
          ? file!.path.toString()
          : (file_path != null)
              ? file_path.toString()
              : '';
      String? img2 = (file2?.path.toString() != null)
          ? file2!.path.toString()
          : (file2_path != null)
              ? file2_path.toString()
              : '';

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
        'value': 'Não funcional',
        'label': 'Não funcional',
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
}
