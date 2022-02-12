import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/Provider/main_provider.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:provider/provider.dart';

class AnimSearchBar extends StatefulWidget {
  ///  width - double ,isRequired : Yes
  ///  textController - TextEditingController  ,isRequired : Yes
  ///  onSuffixTap - Function, isRequired : Yes
  ///  rtl - Boolean, isRequired : No
  ///  autoFocus - Boolean, isRequired : No
  ///  style - TextStyle, isRequired : No
  ///  closeSearchOnSuffixTap - bool , isRequired : No
  ///  suffixIcon - Icon ,isRequired :  No
  ///  prefixIcon - Icon  ,isRequired : No
  ///  animationDurationInMilli -  int ,isRequired : No
  ///  helpText - String ,isRequired :  No
  /// inputFormatters - TextInputFormatter, Required - No

  final double width;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final dynamic onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final List<TextInputFormatter>? inputFormatters;

  const AnimSearchBar({
    Key? key,

    /// The width cannot be null
    required this.width,

    /// The textController cannot be null
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = 'Search...',

    /// choose your custom color
    this.color = Colors.green,

    /// The onSuffixTap cannot be null
    required this.onSuffixTap,
    this.animationDurationInMilli = 375,

    /// make the search bar to open from right to left
    this.rtl = false,

    /// make the keyboard to show automatically when the searchbar is expanded
    this.autoFocus = false,

    /// TextStyle of the contents inside the searchbar
    this.style,

    /// close the search on suffix tap
    this.closeSearchOnSuffixTap = false,

    /// can add list of inputformatters to control the input
    this.inputFormatters,
  }) : super(key: key);

  @override
  _AnimSearchBarState createState() => _AnimSearchBarState();
}

var ref = FirebaseFirestore.instance;

///toggle - 0 => false or closed
///toggle 1 => true or open
int toggle = 0;

class _AnimSearchBarState extends State<AnimSearchBar>
    with SingleTickerProviderStateMixin {
  ///initializing the AnimationController
  late AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    ///Initializing the animationController which is responsible for the expanding and shrinking of the search bar
    _con = AnimationController(
      vsync: this,

      /// animationDurationInMilli is optional, the default value is 375
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  void unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  String? searchKey = '';
  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);
    const radius2 = Radius.circular(10);
    return Container(
      height: 60.0.h,
      width: 349.5.w,

      ///if the rtl is true, search bar will be from right to left
      alignment: widget.rtl ? Alignment.centerRight : const Alignment(-1, 0),

      ///Using Animated container to expand and shrink the widget
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: 48,
        width: (toggle == 0) ? 48.0 : widget.width,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          // border: Border.all(style: BorderStyle.none),

          /// can add custom color or the color will be white
          color: (toggle == 0)
              ? AppColors.transparent
              : AppColors.white, //AppColors.transparent
          borderRadius: const BorderRadius.only(
            bottomLeft: radius,
            topLeft: Radius.circular(10),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.white10,
          //     spreadRadius: -10.0,
          //     blurRadius: 10.0,
          //     offset: Offset(0.0, 10.0),
          //   ),
          // ],
        ),
        child: Stack(
          children: [
            ///Using Animated Positioned widget to expand and shrink the widget
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 0,
              right: 0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  height: 50.0.h,
                  width: 40.w,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    /// can add custom color or the color will be white
                    color: AppColors.darkblue,
                    // borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: AnimatedBuilder(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          ///trying to execute the onSuffixTap function
                          widget.onSuffixTap();

                          ///closeSearchOnSuffixTap will execute if it's true
                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });
                            searchTap();
                          }
                        } catch (e) {
                          ///print the error if the try block fails

                        }
                      },

                      ///suffixIcon is of type Icon
                      child: widget.suffixIcon ??
                          Icon(
                            Icons.search,
                            color: AppColors.white, //heer
                            size: 25.0.sp,
                          ),
                    ),
                    builder: (context, widget) {
                      ///Using Transform.rotate to rotate the suffix icon when it gets expanded
                      return Transform.rotate(
                        angle: _con.value * 2.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              right: (toggle == 0) ? 0.0 : 45.0,
              curve: Curves.easeOut,
              top: 8,

              ///Using Animated opacity to change the opacity of th textField while expanding
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(right: 5),
                  alignment: Alignment.topCenter,
                  width: 255.w,
                  child: TextField(
                    ///Text Controller. you can manipulate the text inside this textField by calling this controller.
                    controller: widget.textController,
                    inputFormatters: widget.inputFormatters,
                    focusNode: focusNode,
                    cursorRadius: const Radius.circular(10),
                    onChanged: (value) {
                      setState(() {
                        searchKey = value;
                      });
                    },
                    onEditingComplete: () async {
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                      await searchTap();

                      /// on editing complete the keyboard will be closed and the search bar will be closed
                    },

                    ///style is of type TextStyle, the default is just a color black
                    style: widget.style ??
                        const TextStyle(
                          color: Colors.black,
                          overflow: TextOverflow.clip,
                        ),
                    cursorColor: Colors.black,
                    textDirection: TextDirection.rtl,

                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: widget.helpText,
                      hintStyle: const TextStyle(
                        color: Color(0xff5B5B5B),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///Using material widget here to get the ripple effect on the prefix icon
            Material(
              /// can add custom color or the color will be white
              color: toggle == 1 ? AppColors.pink : AppColors.transparent,
              borderRadius: const BorderRadius.only(
                bottomLeft: radius2,
                topLeft: Radius.circular(10),
              ),
              child: IconButton(
                splashRadius: 19,

                ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                ///prefixIcon is of type Icon
                icon: widget.prefixIcon != null
                    ? toggle == 1
                        ? const Icon(Icons.arrow_back_ios)
                        : widget.prefixIcon!
                    : Icon(
                        toggle == 1 ? Icons.close : Icons.search,
                        color: toggle == 1 ? AppColors.white : AppColors.white,
                        size: 25.0.sp,
                      ),
                onPressed: () {
                  setState(
                    () {
                      ///if the search bar is closed
                      if (toggle == 0) {
                        toggle = 1;
                        setState(() {
                          ///if the autoFocus is true, the keyboard will pop open, automatically
                          if (widget.autoFocus) {
                            FocusScope.of(context).requestFocus(focusNode);
                          }
                        });

                        ///forward == expand
                        _con.forward();
                      } else {
                        ///if the search bar is expanded
                        toggle = 0;

                        ///if the autoFocus is true, the keyboard will close, automatically
                        setState(() {
                          if (widget.autoFocus) {
                            unfocusKeyboard();
                          }
                        });

                        ///reverse == close
                        _con.reverse();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchTap() async {
    Provider.of<MainProvider>(context, listen: false).changeisLoding(true);
    if (searchKey == null || searchKey == '') {
      Provider.of<MainProvider>(context, listen: false).changeisLoding(false);
      return;
    }
    final res = int.tryParse(searchKey!) ?? -1;
    // if (res != -1) {}

    //start
    if (res != -1) {
      //Search for id
      Provider.of<MainProvider>(context, listen: false).changeSearchResult(ref
          .collection('sellRequest')
          .where('orderStatus', whereIn: ['مقبول', 'محجوز'])
          .where('requestNumber', isEqualTo: res)
          .snapshots());
    } else {
      //Search for contry
      await ref
          .collection('sellRequest')
          .where('country', isEqualTo: searchKey)
          .get();
      Provider.of<MainProvider>(context, listen: false).changeSearchResult(ref
          .collection('sellRequest')
          .where('orderStatus', whereIn: ['مقبول', 'محجوز'])
          .where(
            'country',
            isGreaterThanOrEqualTo: searchKey,
            isLessThan: searchKey!.substring(0, searchKey!.length - 1) +
                String.fromCharCode(
                    searchKey!.codeUnitAt(searchKey!.length - 1) + 1),
          )
          .snapshots());
    }

    Provider.of<MainProvider>(context, listen: false).changeisLoding(false);
  }
}

//end
// var snapshot = await firestoreInstance
//       .collection('categories/subcategory/items')
//       .where(
//         'parameter',
//         isGreaterThanOrEqualTo: searchQuery,
//         isLessThan: searchQuery.substring(0, searchQuery.length - 1) +
//             String.fromCharCode(searchQuery.codeUnitAt(searchQuery.length - 1) + 1),
//       )
//       .get();
