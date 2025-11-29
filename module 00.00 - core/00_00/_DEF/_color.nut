::DEF.Color <- {};
::DEF.Color.NiceGreen <- "#229954";

::DEF.Color.Orange <- "#BA4A00";
::DEF.Color.Purple <- "#8E44AD";
::DEF.Color.Teal <- "#1ABC9C";
::DEF.Color.Gold <- "#F1C40F";
::DEF.Color.Pink <- "#dfabcd";


::DEF.Color.BloodRed <- "#900C3F";
::MSU.Text.color_blood <- function(_string)
{
    return ::Const.UI.getColorized(_string, ::DEF.Color.BloodRed);
}

::DEF.Color.Blue <- "#21618C";
::MSU.Text.color_blue <- function(_string)
{
    return ::Const.UI.getColorized(_string, ::DEF.Color.Blue);
}

// ::DEF.Color.LightBlue <- "#3498DB";
::DEF.Color.LightBlue <- "#4f6676";
::MSU.Text.color_faded_blue <- function(_string)
{
    return ::Const.UI.getColorized(_string, ::DEF.Color.LightBlue);
}

::DEF.Color.Gray <- "#808080";
::MSU.Text.color_gray <- function(_string)
{
    return ::Const.UI.getColorized(_string, ::DEF.Color.Gray);
}