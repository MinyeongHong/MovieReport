import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:ui';
import 'writereview.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  DetailScreen({required this.movie});
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool review=false;
  BannerAd? _banner;
  bool _loadingBanner = false;
  Future<void> _creatBanner(BuildContext context) async{
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getAnchoredAdaptiveBannerAdSize(Orientation.portrait, MediaQuery.of(context).size.width.truncate());
    if(size==null) {return;}
    final BannerAd banner = BannerAd(
      size:size,
      request: AdRequest(),
      adUnitId:BannerAd.testAdUnitId,
      listener: BannerAdListener(
        onAdLoaded :(Ad ad){
          print('$BannerAd loaded.');
          setState((){
            _banner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error){
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }


  @override
  void initState() {
    super.initState();
    review = widget.movie.review;
  }

  @override
  void dispose() {
    super.dispose();
    _banner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!_loadingBanner){
      _loadingBanner = true;
      _creatBanner(context);
    }
    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
          child:Stack(
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    image:DecorationImage(
                        image:NetworkImage(widget.movie.poster),
                        fit:BoxFit.cover,
                    ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.4),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          if(_banner!=null) Container(
                            width: _banner!.size.width.toDouble(),
                            height: _banner!.size.height.toDouble(),
                            child: AdWidget(ad:_banner!),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                            child: Image.network(widget.movie.poster),
                            height: 300,
                          ),
                          Container(
                            width: 250,
                            alignment: Alignment.center,
                            padding:EdgeInsets.all(7),
                            child: Text(widget.movie.genre.toString(),style: TextStyle(color: Color(0xFFF5F5F1),fontSize: 15),),
                          ),
                          Container(
                            padding: EdgeInsets.all(7),
                            child: Text(widget.movie.title,textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 27) ),
                          ),
                          if(widget.movie.year!=null) Text(widget.movie.year,style: TextStyle(color: Color(0xFFF5F5F1)),),
                          Expanded(
                            child:
                            SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.only(top: 1),
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 35),
                                alignment: Alignment.center,
                                child:  Text(widget.movie.description,
                                  style:TextStyle(color: Color(0xFFF5F5F1)),
                                  textAlign: TextAlign.left,)),
                            ),
                          ),
                          SizedBox(height: 30,)
                        ],
                      ),
                    ),
                  ),
                ),

              ),
              Positioned(child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute<Null>(
              fullscreenDialog: true,
              builder: (context){
                return ReviewScreen(movie: widget.movie);
              }
          ));
        },
        label: const Text('평가하기',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold,color: Colors.white)),
        backgroundColor: Color(0xFFC92A2A),
        shape: StadiumBorder(),
        extendedPadding: EdgeInsets.fromLTRB(20, 30, 20, 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
