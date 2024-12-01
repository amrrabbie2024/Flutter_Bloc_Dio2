part of '../view.dart';

class SearchSection extends StatefulWidget {

   SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

final kbloc=KiwiContainer().resolve<TWeatherBloc>();





class _SearchSectionState extends State<SearchSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: InputDecoration(
            suffix: Icon(Icons.search,color: Theme.of(context).primaryColor,),
            hintText: "type here city name",
            hintStyle: TextStyle(color: Colors.orange),
            labelText: "City name",
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius:  BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(20.r),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(20.r),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
          ),
          onFieldSubmitted: (city) {
            kbloc.add(getTWeatherDataEvent(city: city));
          },
        )
      ],
    );
  }
}
