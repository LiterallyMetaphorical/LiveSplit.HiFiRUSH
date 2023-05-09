//Thanks to Candle, Vorime and AFSilver for helping with the addresses!

/*
Scanning Best Practices:

isLoading
loading is a boolean, 1 on loading and 0 elsewhere
*/

state("Hi-Fi-RUSH", "XboxGP v1.0")
{
    bool loading : 0x6FB800C;
}

state("Hi-Fi-RUSH", "Steam v1.0")
{
    bool loading : 0x6E1EBC4;
}

state("Hi-Fi-RUSH", "XboxGP v1.1")
{
    bool loading : 0x6FB707C;
}

state("Hi-Fi-RUSH", "Steam v1.1")
{
    bool loading : 0x6CF1BE4;
}

state("Hi-Fi-RUSH", "XboxGP v1.2")
{
    bool loading : 0x7032BCC;
}

state("Hi-Fi-RUSH", "Steam v1.2")
{
    bool loading : 0x6D6A1F4;
}

state("Hi-Fi-RUSH", "XboxGP v1.3")
{
    bool loading : 0x703E13C;
}

state("Hi-Fi-RUSH", "Steam v1.3")
{
    bool loading : 0x71004CC;
}

state("Hi-Fi-RUSH", "Steam v1.4")
{
    bool loading : 0x70B650C;
}

init
{
switch (modules.First().ModuleMemorySize) 
    {
        case 387805184: 
            version = "XboxGP v1.0";
            break;
        case 401436672: 
            version = "Steam v1.0";
            break;
        case 399798272: 
            version = "XboxGP v1.1";
            break;
        case 407990272: 
            version = "Steam v1.1";
            break;
	case 402980864: 
            version = "XboxGP v1.2";
            break;
	case 410542080:
            version = "Steam v1.2";
            break;
	case 394354688: 
            version = "XboxGP v1.3";
            break; 
	case 411308032:
            version = "Steam v1.3";
            break;
	case 416612352:
            version = "Steam v1.4";
            break; 
        default:
        print("Unknown version detected");
        return false;
    }
}

startup
  {
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Hi-Fi RUSH",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

update
{
//DEBUG CODE 
//print(modules.First().ModuleMemorySize.ToString());
//print(current.loading.ToString()); 
}


isLoading
{
    return current.loading;
}

exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}
