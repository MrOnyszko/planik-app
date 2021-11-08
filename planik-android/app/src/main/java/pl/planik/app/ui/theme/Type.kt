package pl.planik.app.ui.theme

import androidx.compose.material.Typography
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp

val Typography = Typography(
    h1 = TextStyle(
        fontSize = 96.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W300,
        letterSpacing = (-1.5).sp
    ),
    h2 = TextStyle(
        fontSize = 60.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W300,
        letterSpacing = (-0.5).sp
    ),
    h3 = TextStyle(
        fontSize = 48.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W400
    ),
    h4 = TextStyle(
        fontSize = 34.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W400,
        letterSpacing = 0.25.sp
    ),
    h5 = TextStyle(
        fontSize = 24.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W400
    ),
    h6 = TextStyle(
        fontSize = 20.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W500,
        letterSpacing = 0.15.sp
    ),
    subtitle1 = TextStyle(
        fontSize = 16.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W400,
        letterSpacing = 0.15.sp
    ),
    subtitle2 = TextStyle(
        fontSize = 14.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W500,
        letterSpacing = 0.1.sp
    ),
    body1 = TextStyle(
        fontSize = 16.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W400,
        letterSpacing = 0.5.sp
    ),
    body2 = TextStyle(
        fontSize = 14.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W400,
        letterSpacing = 0.25.sp
    ),
    button = TextStyle(
        fontSize = 14.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W500,
        letterSpacing = 1.25.sp
    ),
    caption = TextStyle(
        fontSize = 12.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W400,
        letterSpacing = 0.4.sp
    ),
    overline = TextStyle(
        fontSize = 10.sp,
        fontFamily = FontFamily.Default,
        fontWeight = FontWeight.W400,
        letterSpacing = 1.5.sp
    ),
)