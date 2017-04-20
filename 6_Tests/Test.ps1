try{
    Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
 
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0) 
} catch {
    Throw "Failed to load Windows dll."
}

#-------------------------------------
# UI
#-------------------------------------

# Import Framework assemblies
try{
    Add-Type -AssemblyName PresentationCore,PresentationFramework,WindowsBase,system.windows.forms 
} catch {
    Throw "Failed to load Windows Presentation Framework assemblies."
}

# Import xaml file
[xml]$Global:xmlWPF = Get-Content -Path '.\ScriptUI.xaml' 

# Create UI object
$Global:xamGUI = [Windows.Markup.XamlReader]::Load((new-object System.Xml.XmlNodeReader $xmlWPF)) 

# Create a variable for each control
$xmlWPF.SelectNodes("//*[@Name]") | %{
    Set-Variable -Name ($_.Name) -Value $xamGUI.FindName($_.Name) -Scope Global 
}

#-------------------------------------
# Event Handler 
#-------------------------------------

$buttonConnect.add_Click({    
    $labelError.Content = ""
    $username = $textBoxUsername.Text
    $password = $textBoxPassword.Text

    if ($username -eq "Admin" -And $password -eq "Admin") {
        $CanvasLogin.Visibility = "Hidden"
        $CanvasUser.Visibility = "Visible"
    } else {
        $labelError.Content = "No user found"
    }
})

$buttonServer.add_Click({
    $labelRestart.Content = ""
    $ProgressBar1.Value = 0
    if ($radioButtonServer1.IsChecked) {
        $labelRestart.Content = "Server 1 restarted"
    } else {
        $labelRestart.Content = "Server 2 restarted"
    }
    $ProgressBar1.Value = 100
})

# Display UI object
$xamGUI.ShowDialog() | out-null
