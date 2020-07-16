import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'model/photo_model.dart';

class GalleryScreen extends StatefulWidget {
  PhotoModel photoModel;
  GalleryScreen(this.photoModel);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<GalleryScreen> {

  PageController _pageController;
  int item_selected=0;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.photoModel.index,);
    print(widget.photoModel.imgs.length);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.chevron_left,color: Colors.black,size: 28,),
        ),
        elevation: 1,
        centerTitle: true,
        title: Text("${widget.photoModel.title}"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.photoModel.imgs.length,
                    physics: NeverScrollableScrollPhysics(),itemBuilder: (context,index){
                  return PhotoView(
                   //  initialScale: PhotoViewComputedScale.covered,
                      backgroundDecoration: BoxDecoration(color: Colors.white),
                      imageProvider: CachedNetworkImageProvider(widget.photoModel.imgs[index].src));
                },
                  onPageChanged: (value){
                    setState(() {
                      item_selected = value;
                    });
                  },
                ),
              ),
              Positioned(bottom: 32,left: 1,right: 1,child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(heroTag: widget.photoModel.imgs[0].src,child:Icon(Icons.chevron_left,
                      color: Colors.white,size: 28,),mini: false ,
                      backgroundColor: LightColor.black, onPressed: () {
                        _pageController.previousPage(duration: Duration(milliseconds:300), curve: Curves.easeIn);
                      },)
                    ,SizedBox(width: 8,),
                    FloatingActionButton(heroTag: widget.photoModel.imgs[0].src+"HERO",
                      child:Icon(Icons.chevron_right,color: Colors.white,size: 28,),mini: false ,
                      backgroundColor: LightColor.black, onPressed: () {
                        _pageController.nextPage(duration: Duration(milliseconds:300), curve: Curves.easeIn);
                      },)
                  ],),
              ),)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                for(int index  = 0 ; index < widget.photoModel.imgs.length;index++)
                  Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item_selected == index ?
                        Color.fromRGBO(0, 0, 0, 1) : Color.fromRGBO(0, 0, 0, 0.4)
                    ),
                  )
              ]
          )
      ),
    );
  }


 }

