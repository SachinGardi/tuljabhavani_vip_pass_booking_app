import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulajapur/view/common_widget/progress_indicator.dart';
import '../../view_modal/about_temple_vm/contactus_vm.dart';
import '../common_widget/common_appBar.dart';
import 'contact_us_widgets.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);
  @override
  State<ContactUs> createState() => _ContactUsState();
}
ContactUsVM contactUsVM = Get.put(ContactUsVM());
class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
  setState(() {
    contactUsVM.templeContactDetails.clear();
    contactUsVM.isLoading.value = true;
    contactUsVM.getTempleContactInfo();

  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
          Get.offAllNamed("/dashBoard");
        return false;
      },
      child: Scaffold(
        appBar: allNotification("cAppBarTitle".tr),
        body: Obx(()=>
          ModalProgressHUD(
            color: Colors.black,
            inAsyncCall: contactUsVM.isLoading.value == true,
            progressIndicator: progressIndicator(),
            child:  NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/70,left:MediaQuery.of(context).size.width/35,right: MediaQuery.of(context).size.width/35),
                      child: Container(
                        height: MediaQuery.of(context).size.height/4,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(

                            color: Colors.white.withOpacity(1),
      ),

                        child: GoogleMap(
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(18.012669973575807,
                                76.06609918650668),
                            zoom: 14,
                          ),
                          markers: <Marker>{
                            Marker(
                              markerId: const MarkerId("1"),
                              draggable: true,
                              position: const LatLng(18.012669973575807,
                                  76.06609918650668),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed),
                            )
                          },
                          mapType: MapType.normal,
                          mapToolbarEnabled: true,
                          indoorViewEnabled: true,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: true,
                          myLocationButtonEnabled: false,
                          myLocationEnabled: false,
                          trafficEnabled: true,
                          rotateGesturesEnabled: false,
                          buildingsEnabled: true,
                          liteModeEnabled: true,
                          tiltGesturesEnabled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/60,
                          left:MediaQuery.of(context).size.width/16,
                          right: MediaQuery.of(context).size.width/40,
                      bottom: MediaQuery.of(context).size.height/90),
                      child: Text("आपणास काही अडचण किंवा प्रश्न असल्यास खालील माहितीच्या आधारे संपर्क करू शकता.",style: TextStyle(fontSize: MediaQuery.of(context).size.height/54,
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",color: const Color(0xFFED6A1F)))),
                    information(context,Icons.location_on_outlined, (templeAddress == null)?"":"$templeAddress"),
                    callInformation(context,Icons.call,(contactPerson == null)?"":"$contactPerson"),
                    emailInformation(context,Icons.email,(email1 == null)? "":"$email1",(email2 == null)? "":"$email2"),
                    information(context,Icons.timer, (visitTime == null)? "" : "सोमवार ते रविवार\n$visitTime"),
                    clickableInformation(context,Icons.info,(TemplemoreInfo == null)? "":"$TemplemoreInfo" ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
