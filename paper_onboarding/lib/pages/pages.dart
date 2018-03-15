import 'package:flutter/material.dart';
import 'package:paper_onboarding/pages/page.dart';

final pages = [  
  new PageViewModel(
    Colors.blue, 
    'https://cdn.pixabay.com/photo/2016/05/30/20/54/bass-clef-1425777_960_720.png', 
    'Bass - F Clef', 
    'This is the body',
    null
  ),    
  new PageViewModel(
    Colors.blue, 
    'https://openclipart.org/image/2400px/svg_to_png/270451/tenorkey.png', 
    'Alto - C Clef', 
    'This is the body',
    null
  ),
  new PageViewModel(
    Colors.blue, 
    'https://cdn.pixabay.com/photo/2016/04/07/22/09/note-1314943_960_720.png', 
    'Treble - G Clef', 
    'This is the body',
    null
  ),
];