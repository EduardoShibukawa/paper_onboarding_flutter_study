import 'package:flutter/material.dart';
import 'package:paper_onboarding/pages/page.dart';

final pages = [  
  new PageViewModel(
    const Color(0XFF678FB4),
    'https://cdn.pixabay.com/photo/2016/05/30/20/54/bass-clef-1425777_960_720.png', 
    'Bass - F Clef', 
    'Used for low frequencies instruments like acoustic bass, eletric bass guitar, and many others.',
    'https://cdn.pixabay.com/photo/2016/05/30/20/54/bass-clef-1425777_960_720.png'
  ),    
  new PageViewModel(
    const Color(0XFF65B0B4),
    'https://openclipart.org/image/2400px/svg_to_png/270451/tenorkey.png', 
    'Alto - C Clef', 
    "'Used for middle frequecies insruments nowadays normally used only for viola.",
    'https://openclipart.org/image/2400px/svg_to_png/270451/tenorkey.png'
  ),
  new PageViewModel(
    const Color(0XFF9B90BC),
    'https://cdn.pixabay.com/photo/2016/04/07/22/09/note-1314943_960_720.png', 
    'Treble - G Clef', 
    'Used for high frequencies instruments, most of the instruments use this clef like eletric guitar, flute, and many others.',
    'https://cdn.pixabay.com/photo/2016/04/07/22/09/note-1314943_960_720.png'
  ),
];