//part of '../view.dart';


/*class AllProductsSection extends StatefulWidget {
  const AllProductsSection({super.key});

  @override
  State<AllProductsSection> createState() => _AllProductsSectionState();
}

class _AllProductsSectionState extends State<AllProductsSection> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: kbloc,
      listener: (context, state) {
        /*if(state is ALlProductsFailedState){
          showMessage(state.msg);
        }else if(state is ALlProductsSuccessState){
          showMessage("items coint:- ${state.data.length}",isSucess: true);
        }*/
      },
      builder: (context, state) {
        if(state is ALlProductsFailedState)
          return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
        else if(state is ALlProductsSuccessState)
          return _grid(state.data);
        else
          return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,backgroundColor: Colors.blue,strokeWidth: 8,));
      },
    );
  }

  Widget _grid(List<AllProductsModel> data) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 60.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1
        ),
        itemBuilder: (context, index) =>  _itemGrid(data[index]),
        itemCount: data.length,
      ),
    );
  }

  Widget _itemGrid(AllProductsModel data) {
    return InkWell(
      onTap: () {

      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: AlignmentDirectional.bottomStart,
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Theme.of(context).primaryColor)
                //color: Colors.black
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45.h,),
                Center(child: Directionality(textDirection: TextDirection.ltr,child: Text(data.title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,))),
                //SizedBox(height: 2.h,),
                //Center(child: Text(data.price.toString() + " \$",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),)),
                SizedBox(height: 8.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data.rating.rate.toString(),style:TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500) ,),
                    SizedBox(width: 4.w,),
                    Icon(Icons.star,color: Colors.amber,size: 32,),
                    SizedBox(width: 4.w,),
                    Text("(${data.rating.count})",style:TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500) ,),
                  ],
                ),
               // SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {

                    }, icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,)),
                    Text(data.price.toString() + " \$",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
                    IconButton(onPressed: () {

                    }, icon: Icon(Icons.favorite_border,color: Theme.of(context).primaryColor,))
                  ],
                )
              ],
            ),
          ),
          Positioned(
              right: 10,
              top: -50,
              child: Image.network(data.image,width: 90.w,height: 90.h,fit: BoxFit.fill,)),
        ],
      ),
    );
  }
}*/
