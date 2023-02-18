
import 'package:flutter/material.dart';

class SaleProductPrecnt extends StatefulWidget {
   SaleProductPrecnt({Key? key, required this.color, required this.salePercent, required this.percToShow, required this.salePrice, required this.priceController}) : super(key: key);
final Color color;
     String? salePercent;
     late double salePrice;
     String ?percToShow ;
    late final TextEditingController priceController;

  @override
  State<SaleProductPrecnt> createState() => _SaleProductPrecntState();
}

class _SaleProductPrecntState extends State<SaleProductPrecnt> {




  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        style: TextStyle(color: widget.color),
        items: const [
          DropdownMenuItem<String>(
            value: '10',
            child: Text('10%'),
          ),
          DropdownMenuItem<String>(
            value: '15',
            child: Text('15%'),
          ),
          DropdownMenuItem<String>(
            value: '25',
            child: Text('25%'),
          ),
          DropdownMenuItem<String>(
            value: '50',
            child: Text('50%'),
          ),
          DropdownMenuItem<String>(
            value: '75',
            child: Text('75%'),
          ),
        ],
        onChanged: (value) {
          if (value == '0') {
            return;
          } else {
            setState(() {
              widget.salePercent = value!;
              widget.salePrice = double.parse(widget.priceController.text) -
                  (double.parse(value) * double.parse(widget.priceController.text) / 100);
            });
          }
        },
        hint: Text(widget.salePercent??widget.percToShow!
        ),
        value: widget.salePercent,
      ),
    );
  }
}

