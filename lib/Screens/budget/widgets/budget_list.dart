import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/Screens/budget/widgets/budget_editor.dart';
import 'package:money_manager/db/budget/budget_db.dart';
import 'package:money_manager/models/budgetModel/budget_model.dart';

class BudgetList extends StatefulWidget {
  final BuildContext ctx;

  const BudgetList({super.key, required this.ctx});

  @override
  State<BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  @override
  Widget build(BuildContext context) {
    var tileHeightPortrait = MediaQuery.of(context).size.height > 800
        ? MediaQuery.of(context).size.height * 0.08
        : MediaQuery.of(context).size.height * 0.1;
    var tileHeightLandscape = MediaQuery.of(context).size.height * 0.2;
    var textHeightPortrait = MediaQuery.of(context).size.width * 0.047;
    var textHeightLandscape = MediaQuery.of(context).size.height * 0.05;
    var dateBoxSizePortrait = MediaQuery.of(context).size.height > 800
        ? MediaQuery.of(context).size.height * 0.050
        : MediaQuery.of(context).size.height * 0.057;
    var dateBoxSizeLandscape = MediaQuery.of(context).size.height * 0.12;
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: BudgetDb().BudgetListNotifier,
            builder:
                (BuildContext context, List<BudgetModel> newList, Widget? _) {
              return BudgetDb().BudgetListNotifier.value.isNotEmpty
                  ? SlidableAutoCloseBehavior(
                      child: ListView.builder(
                        itemCount: newList.length,
                        itemBuilder: (context, index) {
                          final data = newList[index];
                          return InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Slidable(
                                  key: Key('$index'),
                                  startActionPane: ActionPane(
                                      motion: const BehindMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (ctx) {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return AlertDialog(
                                                    content: const Text(
                                                        'The Data Will Be Deleted'),
                                                    title: const Text(
                                                        'Are You Sure'),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close)),
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              await BudgetDb()
                                                                  .deleteBudget(
                                                                      data.id);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(
                                                                    'Deleted Successfully',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontFamily:
                                                                            'texgyreadventor-regular',
                                                                        color: const Color.fromARGB(255, 255, 255, 255),
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                              ));
                                                            },
                                                            icon: const Icon(
                                                                Icons.check),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: FontAwesomeIcons.trash,
                                          autoClose: true,
                                          backgroundColor: Colors.red,
                                          label: 'Delete',
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )
                                      ]),
                                  endActionPane: ActionPane(
                                      motion: const BehindMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (ctx) {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return SimpleDialog(
                                                    title: Text(
                                                        'Add a Budget For This Month',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontFamily:
                                                                'texgyreadventor-regular',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                    children: [
                                                      BudgetEditorDialogue(
                                                          ctx: context,
                                                          amount:
                                                              data.BudgetAmount,
                                                          category:
                                                              data.CategoryName,
                                                          id: data.id)
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: FontAwesomeIcons.penToSquare,
                                          autoClose: true,
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 5, 20, 5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          backgroundColor: Colors.blue,
                                          label: 'Edit',
                                        )
                                      ]),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(9, 5, 9, 5),
                                    child: PhysicalModel(
                                      color: Colors.black,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      elevation: 6.0,
                                      child: Container(
                                        width: double.infinity,
                                        height: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? tileHeightPortrait+20
                                            : tileHeightLandscape,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 0, 0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              PhysicalModel(
                                                color: Colors.black,
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                elevation: 4.0,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? dateBoxSizePortrait
                                                      : dateBoxSizeLandscape,
                                                  height: MediaQuery.of(context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? dateBoxSizePortrait
                                                      : dateBoxSizeLandscape,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              232,
                                                              235,
                                                              235),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                     int.parse(data.currentAmount)<=int.parse(data.BudgetAmount)?Column(
                                                       children: [
                                                         Text('₹${int.parse(data.BudgetAmount)-int.parse(data.currentAmount)}',style: TextStyle(fontFamily:'texgyreadventor-regular',fontSize: 20),),
                                                         Text('Left',style: TextStyle(fontFamily:'texgyreadventor-regular',fontSize: 15,fontWeight: FontWeight.w900),),
                                                       ],
                                                     ):Text('Failed',style: TextStyle(fontFamily:'texgyreadventor-regular',color: Colors.red,fontSize: 15,fontWeight: FontWeight.w900),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(data.CategoryName,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .orientation ==
                                                                    Orientation
                                                                        .portrait
                                                                ? textHeightPortrait
                                                                : textHeightLandscape,
                                                            fontFamily:
                                                                'texgyreadventor-regular',
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                2, 39, 71))),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: 170,
                                                      child: LinearProgressIndicator(
                                                        value: data.progress,
                                                        minHeight: 10,
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: data.progress>0.7?Color.fromARGB(255, 255, 0, 0):Colors.green,
                                                        ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text('₹${data.currentAmount}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .portrait
                                                              ? textHeightPortrait +
                                                                  3
                                                              : textHeightLandscape +
                                                                  3,
                                                          fontFamily:
                                                              'texgyreadventor-regular',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color.fromARGB(255, 10, 154, 10))),
                                                          Text(' / ',style: TextStyle(fontSize: 30,fontFamily:'texgyreadventor-regular',fontWeight: FontWeight.w100),),
                                                  Text('₹${data.BudgetAmount}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .portrait
                                                              ? textHeightPortrait +
                                                                  3
                                                              : textHeightLandscape +
                                                                  3,
                                                          fontFamily:
                                                              'texgyreadventor-regular',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.red)),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? textHeightPortrait + 5
                              : textHeightLandscape + 5,
                          fontFamily: 'texgyreadventor-regular',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
            },
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 50,
        )
      ],
    );
  }
}
