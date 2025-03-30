#Requires AutoHotkey v2.0
Persistent

myGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
myGui.SetFont("s10", "Tahoma")
dateText := myGui.AddText("Background0xeeeeee c0x333333 w180 h25 Center vdateText", "")

screenHeight := A_ScreenHeight
guiY := screenHeight - 45
myGui.Show("x10 y" guiY " NoActivate")

SetTimer(CheckFullscreen, 1000)
SetTimer(UpdateDate, 60000)
SetTimer(() => ForceTopmost(myGui.Hwnd), 500)
UpdateDate()

CheckFullscreen() {
    global myGui
    ; Check for a real active window, otherwise skip (desktop has no HWND sometimes)
    if WinExist("A") {
        class := WinGetClass("A")
        if (class = "WorkerW" or class = "Progman") {
            ; desktop clicked – don't hide
            myGui.Show("NoActivate")
            return
        }

        WinGetPos(&x, &y, &w, &h, "A")
        if (w = A_ScreenWidth && h = A_ScreenHeight) {
            myGui.Hide()
        } else {
            myGui.Show("NoActivate")
        }
    }
}

ForceTopmost(hwnd) {
    DllCall("SetWindowPos", "Ptr", hwnd, "Ptr", -1, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "UInt", 0x0003)
}

UpdateDate() {
    rawDate := FormatTime(, "yyyy-MM-dd")
    parts := StrSplit(rawDate, "-")
    jalali := MiladiToShamsi(parts[1], parts[2], parts[3])
    dateText.Text := jalali
}

MiladiToShamsi(y, m, d) {
    y := y + 0, m := m + 0, d := d + 0
    gy := y - 1600, gm := m - 1, gd := d - 1
    g_day_no := 365 * gy + Floor((gy + 3) / 4) - Floor((gy + 99) / 100) + Floor((gy + 399) / 400)
    days_in_month := [31,28,31,30,31,30,31,31,30,31,30,31]
    Loop gm
        g_day_no += days_in_month[A_Index]
    if (gm > 1 && ((Mod(y, 4) = 0 && Mod(y, 100) != 0) || Mod(y, 400) = 0))
        g_day_no += 1
    g_day_no += gd
    j_day_no := g_day_no - 79
    j_np := Floor(j_day_no / 12053)
    j_day_no := Mod(j_day_no, 12053)
    jy := 979 + 33 * j_np + 4 * Floor(j_day_no / 1461)
    j_day_no := Mod(j_day_no, 1461)
    if (j_day_no >= 366) {
        jy += Floor((j_day_no - 1) / 365)
        j_day_no := Mod((j_day_no - 1), 365)
    }
    days := [31,31,31,31,31,31,30,30,30,30,30,29]
    Loop 12 {
        i := A_Index
        if (j_day_no < days[i]) {
            jm := i
            jd := j_day_no + 1
            break
        }
        j_day_no -= days[i]
    }
    weekNames := ["یکشنبه","دوشنبه","سه‌شنبه","چهارشنبه","پنج‌شنبه","جمعه","شنبه"]
    monthNames := ["فروردین","اردیبهشت","خرداد","تیر","مرداد","شهریور","مهر","آبان","آذر","دی","بهمن","اسفند"]
    wday := FormatTime(, "WDay")
    return weekNames[wday] " " jd " " monthNames[jm] " " jy
}

OnExit(*) {
    ExitApp()
}