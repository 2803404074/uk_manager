
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UImage extends CachedNetworkImage {
  final String url;
  final double? mHeight;
  final double? mWidth;
  final BoxFit? mFit;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;

  UImage(this.url, {Key? key, this.borderRadius,this.mWidth,this.mHeight,this.mFit,this.margin})
      : super(key: key, imageUrl: url);

  @override
  ImageWidgetBuilder? get imageBuilder => item;

  @override
  double? get width => mWidth;

  @override
  double? get height => mHeight;

  @override
  LoadingErrorWidgetBuilder? get errorWidget => errView;

  Widget errView(BuildContext context, String url, dynamic error,){
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12,
        borderRadius: BorderRadius.circular(5)
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget item(context, imageProvider) {
    return Container(
      width: mWidth,
      height: mHeight,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius:
        borderRadius ?? const BorderRadius.all(Radius.circular(5.0)),
        image: DecorationImage(
          image: imageProvider,
          fit: mFit??BoxFit.cover,
        ),
      ),
    );
  }
}