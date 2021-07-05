import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/botton_sheet/botton_sheet_widget.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
 final controller = BarcodeScannerController();

 @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if(controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insert_boleto");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [

          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier, 
            builder: (_,status,__) { 
              if(status.showCamera) {
                return Container(child: controller.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),

          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text("Escaneio o código de barras do boleto",
            style: TextStyles.buttonBackground,),
            centerTitle: true,
            leading: BackButton(color: AppColors.background,),
            ),
            body: Column(children: [
                Expanded(child: Container(color: Colors.black,)),
                 Expanded(flex: 2, child: Container(color: Colors.transparent,)),
                  Expanded(child: Container(color: Colors.black.withOpacity(0.8),))
            ],),
            bottomNavigationBar: SetLabelButtons(
                labelPrimary: "Inserir código do boleto", 
                onTapPrimary: () {
                  Navigator.pushReplacementNamed(context, "/inserir_boleto");
                },
                labelSecondary: "Adicionar da galeria", 
                onTapSecondary: () {},
            )
          ),
          ),

          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier, 
            builder: (_,status,__) { 
              if(status.hasError) {
                return BottonSheetWidget(
                  primaryLabel: "Escanear novamente", 
                  primaryOnPressed: () {
                    controller.getAvailableCameras();
                  }, 
                  secondaryLabel: "Digitar código", 
                  secondaryOnPressed: () {}, 
                  title: "Não foi possivel identificar um codigo de barras", 
                  subtitle: "Tente escanear novamente ou digite o códio do seu boleto",
                );
              } else {
                return Container();
              }
            },
          ),

        ],
      ),
    );
  }
}