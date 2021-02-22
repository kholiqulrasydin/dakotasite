import 'package:dakotawebsite/services/auth/report_api.dart';
import 'package:dakotawebsite/viewmodels/bantuan_usaha_view_model.dart';
import 'package:dakotawebsite/widgets/dashboard/widgets/dashboard_widgets.dart';
import 'package:dakotawebsite/widgets/dashboard/widgets/pie_chart/categories_row.dart';
import 'package:dakotawebsite/widgets/dashboard/widgets/pie_chart/pie_chart_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeDashboardDesktop extends StatefulWidget {
  @override
  _HomeDashboardDesktopState createState() => _HomeDashboardDesktopState();
}

class _HomeDashboardDesktopState extends State<HomeDashboardDesktop> {
  int countGallery = 0, countDakota = 0, countPrintedGroup = 0, countPrintedField = 0, countGroup = 0, countAccount = 0, countUser = 0, countAdmin = 0;
  String userName = '';
  ReportApi reportApi = ReportApi();

  Future getCount()async{
    int cGallery = await ReportApi.requestGalleryCountByUser();
    int cDakota = await ReportApi.requestCountDakotaByUser();
    int cPrintedG = await ReportApi.requestWebstatsCountedPrint('countGroupPrinted');
    int cPrintedF = await ReportApi.requestWebstatsCountedPrint('countFieldPrinted');
    int cGroup = await ReportApi.requestCountDakota();
    int cAccount = await ReportApi.requestCountAccount();
    int cUser = await ReportApi.requestCountUser();
    int cAdmin = await ReportApi.requestCountAdmin();
    String uName = await ReportApi.requestUserName();

    setState(() {
      countGallery = cGallery;
      countDakota = cDakota;
      countPrintedGroup = cPrintedG;
      countPrintedField = cPrintedF;
      countGroup = cGroup;
      countAccount = cAccount;
      countUser = cUser;
      countAdmin = cAdmin;
      userName = uName;
    });
  }

  // void _processCategory(BantuanUsahaViewModel bantuanUsahaViewModel) {
  //   bantuanUsahaViewModel.categoryset = bantuanUsahaViewModel.bantuanUsahaCountList;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BantuanUsahaViewModel bantuanUsahaViewModel =
    Provider.of<BantuanUsahaViewModel>(context, listen: false);
    if(bantuanUsahaViewModel.bantuanUsahaCountList.isEmpty){
    BantuanUsahaViewModel.getBantuanUsahaCountAll(bantuanUsahaViewModel);
    }
    getCount();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: Consumer<BantuanUsahaViewModel>(
        builder:(_, bantuanUsaha, __) {
          return Center(
            child: bantuanUsaha.category.isEmpty || userName == '' ? CircularProgressIndicator() : Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
              child: Row(
                children: [
                  Flexible(
                      flex: 7,
                      child: StatisticDashboard(countDakota: countDakota, countGallery: countGallery)
                  ),
                  Flexible(
                      flex: 9,
                      child: NumericDashboard(userName: userName,countPrintedGroup: countPrintedGroup, countPrintedField: countPrintedField, countDakota: countGroup, countAccount: countAccount, countUser: countUser, countAdmin: countAdmin)
                  )
                ],
              ),
            ),
          );
        }
      )
    );
  }
}

class NumericDashboard extends StatelessWidget {
  const NumericDashboard({
    Key key,
    @required this.countPrintedGroup,
    @required this.countPrintedField,
    @required this.countDakota,
    @required this.countAccount,
    @required this.countUser,
    @required this.countAdmin,
    @required this.userName
  }) : super(key: key);

  final int countPrintedGroup;
  final int countPrintedField;
  final int countDakota;
  final int countAccount;
  final int countUser;
  final int countAdmin;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.005),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Text('Statistik Laporan', style: TextStyle(fontSize: 16),),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Row(
                  children: [
                    InfoNumeric(numColor: Colors.deepPurple, titleColor: Colors.deepPurple.shade200, title: 'Informasi\nkelompok tercetak', value: countPrintedGroup.toString(),),
                    InfoNumeric(numColor: Colors.amber, titleColor: Colors.amber.shade200, title: 'Informasi\nlahan tercetak', value: countPrintedField.toString(),),
                    InfoNumeric(numColor: Colors.teal, titleColor: Colors.teal.shade200, title: 'Total kelompok\nterdata', value: countDakota.toString(),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 70),
                  child: Divider(
                    thickness: 1.5,
                    color: Colors.blueGrey,
                  ),
                ),
                Row(
                  children: [
                    InfoNumeric(numColor: Colors.red, titleColor: Colors.red.shade200, title: 'Total akun\nterdaftar', value: countAccount.toString(),),
                    InfoNumeric(numColor: Colors.blueGrey, titleColor: Colors.blueGrey.shade200, title: 'Total akun penyuluh', value: countUser.toString(),),
                    InfoNumeric(numColor: Colors.blueAccent, titleColor: Colors.blueAccent.shade200, title: 'Total akun admin', value: countAdmin.toString(),),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03, bottom: MediaQuery.of(context).size.height * 0.05, top: MediaQuery.of(context).size.height * 0.05 ),
              child: OnHoverGreetingsCard(
                color: Color.fromRGBO(96,125,139,1),
                projectName: 'Semoga Hari Anda Menyenangkan.',
                percentComplete: 'Hai $userName !',
                progressIndicatorColor: Color.fromRGBO(144,164,174,1),
                icon: Icons.verified,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticDashboard extends StatelessWidget {
  const StatisticDashboard({
    Key key,
    @required this.countDakota,
    @required this.countGallery,
  }) : super(key: key);

  final int countDakota;
  final int countGallery;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
          child: Text('Total Bantuan Usaha Terdata', style: TextStyle(fontSize: 18),),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Container(width: MediaQuery.of(context).size.width * 0.2, height: MediaQuery.of(context).size.width * 0.2, child: Consumer<BantuanUsahaViewModel>(builder: (_, viewModel, __) => PieChartView(categoryData: viewModel.category,))),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
              CategoriesRow()
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
          child: Text('Statistik Anda', style: TextStyle(fontSize: 16),),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
            child: Row(
              children: [
                OnHoverCard(
                  color: Color(0xffFF4C60),
                  projectName: 'total kelompok\nterdata oleh anda',
                  percentComplete: '$countDakota',
                  progressIndicatorColor: Colors.redAccent[100],
                  icon: Icons.people_outline,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                OnHoverCard(
                  color: Colors.blue,
                  projectName: 'total foto kegiatan\nditambahkan\noleh anda',
                  percentComplete: '$countGallery',
                  progressIndicatorColor: Colors.blue.shade100,
                  icon: Icons.add_photo_alternate_outlined,
                ),
                // ExpandedInfo(onPressed: () {}, numValue: '$countDakota', title: 'total kelompok\nterdata oleh anda', numColor: Colors.deepOrange, titleColor: Colors.deepOrange.shade100,),
                // ExpandedInfo(onPressed: () {}, numValue: '$countGallery', title: 'total foto kegiatan\nditambahkan oleh anda', numColor: Colors.blue, titleColor: Colors.blue.shade100,),
              ],
            ),
          )
        )
      ],
    );
  }
}


