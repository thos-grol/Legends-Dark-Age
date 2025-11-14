//helper/semantic fns to make overhaul clearer
::Const.CharacterProperties.getMettle <- function()
{
    return this.getBravery();
}

// ::Const.CharacterProperties.getInitiative
::Const.CharacterProperties.getAgility <- function()
{
    return this.getInitiative();
}