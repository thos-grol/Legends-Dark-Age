// =================================================================================================
// Definitions
// =================================================================================================

::Color <- {};

::Color.Blue <- "#21618C";

::Color.NiceGreen <- "#229954";
::Color.NiceYellow <- "#737300";
::Color.NiceRed <- "#99222C";

::Color.Orange <- "#BA4A00";
::Color.Purple <- "#8E44AD";
::Color.Teal <- "#1ABC9C";
::Color.Gold <- "#F1C40F";
::Color.Pink <- "#dfabcd";
::Color.BloodRed <- "#900C3F";

::Color.Gray <- "#808080";

::Color.hit_result <- {};

::Color.hit_result[HIT_RESULT.MISS] <- ::Color.NiceRed;
::Color.hit_result[HIT_RESULT.GRAZE] <- ::Color.NiceYellow;
::Color.hit_result[HIT_RESULT.HIT] <- ::Color.NiceGreen;


// =================================================================================================
// Syntactic Sugar fns
// =================================================================================================

::color <- function(c, msg) { return ::Const.UI.getColorized(msg, c); }

::red <- function(msg) { return ::color(::Const.UI.Color.NegativeValue, msg); }
::green <- function(msg) { return ::color(::Const.UI.Color.PositiveValue, msg); }
::blue <- function(msg) { return ::color(::Color.Blue, msg); }

::damagered <- function(msg) { return ::color(::Const.UI.Color.DamageValue, msg); }
::bloodred <- function(msg) { return ::color(::Color.BloodRed, msg); }
::lightblue <- function(msg) { return ::color(::Color.LightBlue, msg); }
::nicegreen <- function(msg) { return ::color(::Color.NiceGreen, msg); }
::niceyellow <- function(msg) { return ::color(::Color.NiceYellow, msg); }
::nicered <- function(msg) { return ::color(::Color.NiceRed, msg); }
::gray <- function(msg) { return ::color(::Color.Gray, msg); }

::color_name <- function(msg) { return ::Const.UI.getColorizedEntityName(msg); }
