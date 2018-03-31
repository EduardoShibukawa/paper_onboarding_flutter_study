import 'package:flutter/material.dart';
import 'package:paper_onboarding/pages/page.dart';

final pages = [  
  new PageViewModel(
    const Color(0XFF678FB4),
    'assets/f_clef.png', 
    'Bass - F Clef', 
    'Used for low frequencies instruments like acoustic bass, eletric bass guitar, and many others.',
    'assets/f_clef.png'
  ),    
  new PageViewModel(
    const Color(0XFF65B0B4),
    'assets/c_clef.png', 
    'Alto - C Clef', 
    'Used for middle frequecies instruments nowadays normally used only for viola.',
    'assets/c_clef.png'
  ),
  new PageViewModel(
    const Color(0XFF9B90BC),
    'assets/g_clef.png', 
    'Treble - G Clef', 
    'Used for high frequencies instruments, most of the instruments use this clef like eletric guitar, flute, and many others.',
    'assets/g_clef.png'
  ),
];