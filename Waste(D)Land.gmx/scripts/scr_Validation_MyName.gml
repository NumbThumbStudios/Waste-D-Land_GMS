var n = argument0;

if(string_replace_all(n, " ","") == "")
{
    if(!instance_exists(obj_Message_Generic_NoOptions)) 
    { 
        with(instance_create(0,0,obj_Message_Generic_NoOptions))
        {
            str_Title = "C'MON NOW, REALLY?";
            str_Info  = "You need to at least enter something! What the fuck
                        #is wrong with you, dumbass?";
            state = "None"; 
        }
    }
}
else
if(string_length(n) < 2)
{
    if(!instance_exists(obj_Message_Generic_NoOptions)) 
    { 
        with(instance_create(0,0,obj_Message_Generic_NoOptions))
        {
            str_Title = "NAME TO SHORT";
            str_Info  = "You need to enter a name that's at LEAST 2 characters
                        #long, dumbass.";
            state = "None"; 
        }
    }
}
else
if(string_length(n) > 16)
{
    var t = "";
    
    for(var i = 1; i < 16; i ++)
    {
        t += string_char_at(n, i);
    }

    myName = t;
}
else
{
    myName = n;
}

