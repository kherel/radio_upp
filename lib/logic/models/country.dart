// ignore_for_file: constant_identifier_names

enum Country {
  AF,
  AD,
  AE,
  AG,
  AL,
  AM,
  AO,
  AR,
  AT,
  AU,
  AW,
  AZ,
  BA,
  BD,
  BE,
  BG,
  BI,
  BJ,
  BM,
  BO,
  BR,
  BS,
  BW,
  BY,
  CA,
  CG,
  CH,
  CI,
  CL,
  CM,
  CO,
  CR,
  CW,
  CY,
  CZ,
  DE,
  DK,
  DM,
  DO,
  DZ,
  EC,
  EE,
  EG,
  ES,
  ET,
  FI,
  FJ,
  FR,
  GD,
  GH,
  GR,
  GT,
  GY,
  HK,
  HN,
  HR,
  HT,
  HU,
  ID,
  IE,
  IL,
  IN,
  IQ,
  IR,
  IS,
  IT,
  JM,
  JO,
  JP,
  KE,
  KR,
  LB,
  LC,
  LI,
  LK,
  LT,
  LU,
  LV,
  LY,
  MA,
  MG,
  MK,
  ML,
  MT,
  MU,
  MX,
  MY,
  NA,
  NG,
  NI,
  NL,
  NO,
  NP,
  NZ,
  OM,
  PA,
  PE,
  PH,
  PK,
  PL,
  PS,
  PT,
  PY,
  RO,
  RS,
  RU,
  SA,
  SD,
  SE,
  SG,
  SI,
  SK,
  SL,
  SM,
  SN,
  SR,
  SV,
  SY,
  TG,
  TH,
  TN,
  TR,
  TT,
  TZ,
  UA,
  UG,
  UK,
  US,
  UY,
  VC,
  VE,
  VN,
  ZA,
  ZW
}

extension CountriesExt on Country {
  String get name {
    switch (this) {
      case Country.AF:
        return "Afghanistan";
      case Country.AD:
        return "Andorra";
      case Country.AE:
        return "United Arab Emirates";
      case Country.AG:
        return "Antigua and Barbuda";
      case Country.AL:
        return "Albania";
      case Country.AM:
        return "Armenia";
      case Country.AO:
        return "Angola";
      case Country.AR:
        return "Argentina";
      case Country.AT:
        return "Austria";
      case Country.AU:
        return "Australia";
      case Country.AW:
        return "Aruba";
      case Country.AZ:
        return "Azerbaijan";
      case Country.BA:
        return "Bosnia and Herzegovina";
      case Country.BD:
        return "Bangladesh";
      case Country.BE:
        return "Belgium";
      case Country.BG:
        return "Bulgaria";
      case Country.BI:
        return "Burundi";
      case Country.BJ:
        return "Benin";
      case Country.BM:
        return "Bermuda";
      case Country.BO:
        return "Bolivia";
      case Country.BR:
        return "Brazil";
      case Country.BS:
        return "Bahamas the";
      case Country.BW:
        return "Botswana";
      case Country.BY:
        return "Belarus";
      case Country.CA:
        return "Canada";
      case Country.CG:
        return "Congo the";
      case Country.CH:
        return "Switzerland";
      case Country.CI:
        return "Cote d'Ivoire";
      case Country.CL:
        return "Chile";
      case Country.CM:
        return "Cameroon";
      case Country.CO:
        return "Colombia";
      case Country.CR:
        return "Costa Rica";
      case Country.CW:
        return "CW";
      case Country.CY:
        return "Cyprus";
      case Country.CZ:
        return "Czech Republic";
      case Country.DE:
        return "Germany";
      case Country.DK:
        return "Denmark";
      case Country.DM:
        return "Dominica";
      case Country.DO:
        return "Dominican Republic";
      case Country.DZ:
        return "Algeria";
      case Country.EC:
        return "Ecuador";
      case Country.EE:
        return "Estonia";
      case Country.EG:
        return "Egypt";
      case Country.ES:
        return "Spain";
      case Country.ET:
        return "Ethiopia";
      case Country.FI:
        return "Finland";
      case Country.FJ:
        return "Fiji the Fiji Islands";
      case Country.FR:
        return "France";
      case Country.GD:
        return "Grenada";
      case Country.GH:
        return "Ghana";
      case Country.GR:
        return "Greece";
      case Country.GT:
        return "Guatemala";
      case Country.GY:
        return "Guyana";
      case Country.HK:
        return "Hong Kong";
      case Country.HN:
        return "Honduras";
      case Country.HR:
        return "Croatia";
      case Country.HT:
        return "Haiti";
      case Country.HU:
        return "Hungary";
      case Country.ID:
        return "Indonesia";
      case Country.IE:
        return "Ireland";
      case Country.IL:
        return "Israel";
      case Country.IN:
        return "India";
      case Country.IQ:
        return "Iraq";
      case Country.IR:
        return "Iran";
      case Country.IS:
        return "Iceland";
      case Country.IT:
        return "Italy";
      case Country.JM:
        return "Jamaica";
      case Country.JO:
        return "Jordan";
      case Country.JP:
        return "Japan";
      case Country.KE:
        return "Kenya";
      case Country.KR:
        return "Korea";
      case Country.LB:
        return "Lebanon";
      case Country.LC:
        return "Saint Lucia";
      case Country.LI:
        return "Liechtenstein";
      case Country.LK:
        return "Sri Lanka";
      case Country.LT:
        return "Lithuania";
      case Country.LU:
        return "Luxembourg";
      case Country.LV:
        return "Latvia";
      case Country.LY:
        return "Libyan Arab Jamahiriya";
      case Country.MA:
        return "Morocco";
      case Country.MG:
        return "Madagascar";
      case Country.MK:
        return "Macedonia";
      case Country.ML:
        return "Mali";
      case Country.MT:
        return "Malta";
      case Country.MU:
        return "Mauritius";
      case Country.MX:
        return "Mexico";
      case Country.MY:
        return "Malaysia";
      case Country.NA:
        return "Namibia";
      case Country.NG:
        return "Nigeria";
      case Country.NI:
        return "Nicaragua";
      case Country.NL:
        return "Netherlands";
      case Country.NO:
        return "Norway";
      case Country.NP:
        return "Nepal";
      case Country.NZ:
        return "New Zealand";
      case Country.OM:
        return "Oman";
      case Country.PA:
        return "Panama";
      case Country.PE:
        return "Peru";
      case Country.PH:
        return "Philippines";
      case Country.PK:
        return "Pakistan";
      case Country.PL:
        return "Poland";
      case Country.PS:
        return "Palestinian Territory";
      case Country.PT:
        return "Portugal";
      case Country.PY:
        return "Paraguay";
      case Country.RO:
        return "Romania";
      case Country.RS:
        return "Serbia";
      case Country.RU:
        return "Russian Federation";
      case Country.SA:
        return "Saudi Arabia";
      case Country.SD:
        return "Sudan";
      case Country.SE:
        return "Sweden";
      case Country.SG:
        return "Singapore";
      case Country.SI:
        return "Slovenia";
      case Country.SK:
        return "Slovakia";
      case Country.SL:
        return "Sierra Leone";
      case Country.SM:
        return "San Marino";
      case Country.SN:
        return "Senegal";
      case Country.SR:
        return "Suriname";
      case Country.SV:
        return "El Salvador";
      case Country.SY:
        return "Syria";
      case Country.TG:
        return "Togo";
      case Country.TH:
        return "Thailand";
      case Country.TN:
        return "Tunisia";
      case Country.TR:
        return "Turkey";
      case Country.TT:
        return "Trinidad and Tobago";
      case Country.TZ:
        return "Tanzania";
      case Country.UA:
        return "Ukraine";
      case Country.UG:
        return "Uganda";
      case Country.UK:
        return "United Kingdom";
      case Country.US:
        return "United States";
      case Country.UY:
        return "Uruguay";
      case Country.VC:
        return "Saint Vincent and the Grenadines";
      case Country.VE:
        return "Venezuela";
      case Country.VN:
        return "Vietnam";
      case Country.ZA:
        return "South Africa";
      case Country.ZW:
        return "Zimbabwe";
    }
  }
}
