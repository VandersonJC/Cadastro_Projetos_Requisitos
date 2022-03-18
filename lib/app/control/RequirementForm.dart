import 'package:cadastro_projeto_requerimento/app/control/ProjectControl.dart';
import 'package:cadastro_projeto_requerimento/app/models/Project.dart';
import 'package:cadastro_projeto_requerimento/app/models/Requirement.dart';
import 'package:cadastro_projeto_requerimento/app/util/VDate.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class RequirementForm extends StatelessWidget {
  RequirementForm({required this.ref_project, this.requirement});

  int ref_project;
  Requirement? requirement;

  @override
  Widget build(BuildContext context) {
    return RequirementFormDinamic(
      ref_project: ref_project,
      requirement: requirement
    );
  }
}

class RequirementFormDinamic extends StatefulWidget {
  RequirementFormDinamic({required this.ref_project, this.requirement});

  int ref_project;
  Requirement? requirement;

  @override
  State<RequirementFormDinamic> createState() =>
      _RequirementFormDinamic(ref_project: ref_project, requirementEdit: requirement);
}

class _RequirementFormDinamic extends State<RequirementFormDinamic> {
  // This widget is the root of your application.
  _RequirementFormDinamic({required this.ref_project, this.requirementEdit});

  final TextEditingController con_desciption = TextEditingController();
  final TextEditingController con_tp_requirement = TextEditingController();
  String? con_dt_register = VDate.ConvertDatetimeInString(DateTime.now());
  final TextEditingController con_dt_end     = TextEditingController();
  final TextEditingController con_priority   = TextEditingController();
  final TextEditingController con_level_complexity = TextEditingController();
  final TextEditingController con_time_work_estemeed = TextEditingController();

  Requirement? requirementEdit;

  int ref_project;
  Project? project;

  RequirementHelper requirementHelper = RequirementHelper();
  ProjectHelper projectHelper = ProjectHelper();

  @override
  void initState() {
    if( requirementEdit?.id != null ) 
    {
      onLoad(requirementEdit!);
    }
    projectHelper.getProject(ref_project).then((value) => project = value);

    super.initState();
  }

  void onLoad(Requirement requirement)
  {
    setState(() {
      con_desciption.text = requirement.description!;
      con_dt_end.text = requirement.dt_end!;
      con_time_work_estemeed.text = requirement.time_work_estemeed!;
      con_tp_requirement.text = requirement.tp_requirement!;
      con_priority.text = requirement.priority!;
      con_level_complexity.text =  requirement.level_complexity!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de requisitos'),
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
                                label: Text('Descrição'),
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
                                onChanged: (val) => {con_tp_requirement.text = val},
                                onSaved: (val) => {con_tp_requirement.text = val!},
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
                                label: Text('Data Final'),
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
                                  label: Text('Prioridade'),
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
                                icon: Icon(Icons.arrow_drop_down),
                                labelText: 'Nível de complexidade',
                                items: getItems(),
                                onChanged: (val) => {con_level_complexity.text = val},
                                onSaved: (val) => {con_level_complexity.text = val!},
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  label: Text('Nível de complexidade'),
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
                                label:
                                    Text('Tempo estimado de trabalho(Minutos)'),
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
                                    primary: Color(0xff00d7f3),
                                    padding: const EdgeInsets.all(15),
                                  ),
                                  child: const Text('Salvar'),
                                  onPressed: () {
                                    onSave();
                                  })))),
                ]))));
  }

  void onSave() {
    try {
      String desciption = con_desciption.text;
      String dt_end = con_dt_end.text;
      String time_work_estemeed = con_time_work_estemeed.text;
      String tp_requirement    = con_tp_requirement.text;
      String level_complexity = con_level_complexity.text;
      String priority = con_priority.text;
      String dt_register = con_dt_register!;

      Requirement objRequirement = Requirement();

      objRequirement.description = desciption;
      objRequirement.dt_end = dt_end;
      objRequirement.time_work_estemeed = time_work_estemeed;
      objRequirement.tp_requirement = tp_requirement;
      objRequirement.level_complexity = level_complexity;
      objRequirement.priority = con_priority.text;
      objRequirement.dt_register = dt_register;
      objRequirement.ref_project = ref_project;

      if( requirementEdit?.id != null )
      {
        objRequirement.id = requirementEdit!.id;
        objRequirement.dt_register = requirementEdit!.dt_register;
        requirementHelper.updateRequirement(objRequirement);  
      }
      else
      {
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
        'icon': Icon(Icons.circle),
      },
      {
        'value': 'Medio',
        'label': 'Medio',
        'icon': Icon(Icons.circle),
      },
      {
        'value': 'Baixo',
        'label': 'Baixo',
        'icon': Icon(Icons.circle),
      },
    ];
    return _items;
  }

  List<Map<String, dynamic>> getItemsType() {
    final List<Map<String, dynamic>> _items = [
      {
        'value': 'Funcional',
        'label': 'Funcional',
        'icon': Icon(Icons.circle),
      },
      {
        'value': 'Não funcional',
        'label': 'Não funcional',
        'icon': Icon(Icons.circle),
      },
    ];
    return _items;
  }
}
