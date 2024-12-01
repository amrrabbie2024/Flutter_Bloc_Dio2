part of 'bloc.dart';

class YWeatherData {

  late final Location location;
  late final Current current;
  late final Forecast forecast;

  YWeatherData.fromJson(Map<String, dynamic> json){
    location = Location.fromJson(json['location']);
    current = Current.fromJson(json['current']);
    forecast = Forecast.fromJson(json['forecast']);
  }


}

class Location {

  late final String name;
  late final String region;
  late final String country;
  late final double lat;
  late final double lon;
  late final String tzId;
  late final int localtimeEpoch;
  late final String localtime;

  Location.fromJson(Map<String, dynamic> json){
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    tzId = json['tz_id'];
    localtimeEpoch = json['localtime_epoch'];
    localtime = json['localtime'];
  }


}

class Current {

  late final int lastUpdatedEpoch;
  late final String lastUpdated;
  late final double tempC;
  late final double tempF;
  late final int isDay;
  late final Condition condition;
  late final double windMph;
  late final double windKph;
  late final int windDegree;
  late final String windDir;
  late final num pressureMb;
  late final num pressureIn;
  late final double precipMm;
  late final num precipIn;
  late final int humidity;
  late final int cloud;
  late final double feelslikeC;
  late final double feelslikeF;
  late final num windchillC;
  late final double windchillF;
  late final double heatindexC;
  late final double heatindexF;
  late final double dewpointC;
  late final double dewpointF;
  late final num visKm;
  late final num visMiles;
  late final double uv;
  late final double gustMph;
  late final double gustKph;

  Current.fromJson(Map<String, dynamic> json){
    lastUpdatedEpoch = json['last_updated_epoch'];
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    condition = Condition.fromJson(json['condition']);
    windMph = json['wind_mph'];
    windKph = json['wind_kph'];
    windDegree = json['wind_degree'];
    windDir = json['wind_dir'];
    pressureMb = json['pressure_mb'];
    pressureIn = json['pressure_in'];
    precipMm = json['precip_mm'];
    precipIn = json['precip_in'];
    humidity = json['humidity'];
    cloud = json['cloud'];
    feelslikeC = json['feelslike_c'];
    feelslikeF = json['feelslike_f'];
    windchillC = json['windchill_c'];
    windchillF = json['windchill_f'];
    heatindexC = json['heatindex_c'];
    heatindexF = json['heatindex_f'];
    dewpointC = json['dewpoint_c'];
    dewpointF = json['dewpoint_f'];
    visKm = json['vis_km'];
    visMiles = json['vis_miles'];
    uv = json['uv'];
    gustMph = json['gust_mph'];
    gustKph = json['gust_kph'];
  }


}

class Condition {

  late final String text;
  late final String icon;
  late final int code;

  Condition.fromJson(Map<String, dynamic> json){
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }


}

class Forecast {

  late final List<Forecastday> forecastday;

  Forecast.fromJson(Map<String, dynamic> json){
    forecastday = List.from(json['forecastday']).map((e)=>Forecastday.fromJson(e)).toList();
  }


}

class Forecastday {

  late final String date;
  late final int dateEpoch;
  late final Day day;
  late final Astro astro;
  late final List<Hour> hour;

  Forecastday.fromJson(Map<String, dynamic> json){
    date = json['date'];
    dateEpoch = json['date_epoch'];
    day = Day.fromJson(json['day']);
    astro = Astro.fromJson(json['astro']);
    hour = List.from(json['hour']).map((e)=>Hour.fromJson(e)).toList();
  }


}

class Day {

  late final double maxtempC;
  late final double maxtempF;
  late final double mintempC;
  late final double mintempF;
  late final double avgtempC;
  late final num avgtempF;
  late final double maxwindMph;
  late final double maxwindKph;
  late final double totalprecipMm;
  late final double totalprecipIn;
  late final num totalsnowCm;
  late final num avgvisKm;
  late final num avgvisMiles;
  late final int avghumidity;
  late final int dailyWillItRain;
  late final int dailyChanceOfRain;
  late final int dailyWillItSnow;
  late final int dailyChanceOfSnow;
  late final Condition condition;
  late final double uv;

  Day.fromJson(Map<String, dynamic> json){
    maxtempC = json['maxtemp_c'];
    maxtempF = json['maxtemp_f'];
    mintempC = json['mintemp_c'];
    mintempF = json['mintemp_f'];
    avgtempC = json['avgtemp_c'];
    avgtempF = json['avgtemp_f'];
    maxwindMph = json['maxwind_mph'];
    maxwindKph = json['maxwind_kph'];
    totalprecipMm = json['totalprecip_mm'];
    totalprecipIn = json['totalprecip_in'];
    totalsnowCm = json['totalsnow_cm'];
    avgvisKm = json['avgvis_km'];
    avgvisMiles = json['avgvis_miles'];
    avghumidity = json['avghumidity'];
    dailyWillItRain = json['daily_will_it_rain'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    dailyWillItSnow = json['daily_will_it_snow'];
    dailyChanceOfSnow = json['daily_chance_of_snow'];
    condition = Condition.fromJson(json['condition']);
    uv = json['uv'];
  }


}

class Astro {

  late final String sunrise;
  late final String sunset;
  late final String moonrise;
  late final String moonset;
  late final String moonPhase;
  late final int moonIllumination;
  late final int isMoonUp;
  late final int isSunUp;

  Astro.fromJson(Map<String, dynamic> json){
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    moonIllumination = json['moon_illumination'];
    isMoonUp = json['is_moon_up'];
    isSunUp = json['is_sun_up'];
  }


}

class Hour {

  late final int timeEpoch;
  late final String time;
  late final double? tempC;
  late final double? tempF;
  late final int isDay;
  late final Condition condition;
  late final double? windMph;
  late final double? windKph;
  late final int windDegree;
  late final String windDir;
  late final num pressureMb;
  late final double? pressureIn;
  late final num? precipMm;
  late final num? precipIn;
  late final num snowCm;
  late final int humidity;
  late final int cloud;
  late final double? feelslikeC;
  late final double? feelslikeF;
  late final double? windchillC;
  late final double? windchillF;
  late final double? heatindexC;
  late final double? heatindexF;
  late final double? dewpointC;
  late final double? dewpointF;
  late final int willItRain;
  late final int chanceOfRain;
  late final int willItSnow;
  late final int chanceOfSnow;
  late final num visKm;
  late final num visMiles;
  late final double? gustMph;
  late final double gustKph;
  late final num? uv;

  Hour.fromJson(Map<String, dynamic> json){
    timeEpoch = json['time_epoch'];
    time = json['time'];
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    condition = Condition.fromJson(json['condition']);
    windMph = json['wind_mph'];
    windKph = json['wind_kph'];
    windDegree = json['wind_degree'];
    windDir = json['wind_dir'];
    pressureMb = json['pressure_mb'];
    pressureIn = json['pressure_in'];
    precipMm = json['precip_mm'];
    precipIn = json['precip_in'];
    snowCm = json['snow_cm'];
    humidity = json['humidity'];
    cloud = json['cloud'];
    feelslikeC = json['feelslike_c'];
    feelslikeF = json['feelslike_f'];
    windchillC = json['windchill_c'];
    windchillF = json['windchill_f'];
    heatindexC = json['heatindex_c'];
    heatindexF = json['heatindex_f'];
    dewpointC = json['dewpoint_c'];
    dewpointF = json['dewpoint_f'];
    willItRain = json['will_it_rain'];
    chanceOfRain = json['chance_of_rain'];
    willItSnow = json['will_it_snow'];
    chanceOfSnow = json['chance_of_snow'];
    visKm = json['vis_km'];
    visMiles = json['vis_miles'];
    gustMph = json['gust_mph'];
    gustKph = json['gust_kph'];
    uv = json['uv'];
  }


}