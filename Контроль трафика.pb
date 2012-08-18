
Enumeration
  #MAIN_WINDOW
EndEnumeration

Enumeration
  #MENU_BAR
EndEnumeration

Enumeration
  #ACTION_EXIT
  
  #ACTION_ABOUT
EndEnumeration

Enumeration
  #TRAFFIC_TEXT
  #TRAFFIC_STRING
  
  #TRAFFIC_COMBO_BOX
  
  #DAYS_TEXT
  #DAYS_STRING
  
  #CALCULATE_BUTTON
  
  #RESULT_TEXT
  #RESULT_STRING
  
  #RESULT_COMBO_BOX
EndEnumeration

Enumeration
  #UNITS_MB
  #UNITS_GB
EndEnumeration


Procedure OpenMainWindow()
  
  If OpenWindow(#MAIN_WINDOW, #PB_Ignore, #PB_Ignore, 270, 295, "Контроль трафика", #PB_Window_MinimizeGadget | #PB_Window_ScreenCentered)
    If CreateMenu(#MENU_BAR, WindowID(#MAIN_WINDOW)) 
      MenuTitle("&Файл")
      MenuItem(#ACTION_EXIT, "В&ыход")
      
      MenuTitle("&Справка")
      MenuItem(#ACTION_ABOUT, "&О программе")
    EndIf
    
    TextGadget(#TRAFFIC_TEXT,           20,  20, 230, 20, "Введите количество трафика:", #PB_Text_Center)
    StringGadget(#TRAFFIC_STRING,       20,  45, 180, 20, "",                            #PB_Text_Center | #PB_String_Numeric)
    
    ComboBoxGadget(#TRAFFIC_COMBO_BOX, 210,  45,  40, 20)
    
    TextGadget(#DAYS_TEXT,              20,  90, 230, 20, "Введите количество дней:",    #PB_Text_Center)
    StringGadget(#DAYS_STRING,          20, 115, 230, 20, "",                            #PB_Text_Center | #PB_String_Numeric)
    
    ButtonGadget(#CALCULATE_BUTTON,     70, 160, 130, 25, "Рассчитать")
    
    TextGadget(#RESULT_TEXT,            20, 205, 230, 20, "Норма в день:",               #PB_Text_Center)
    TextGadget(#RESULT_STRING,          20, 230, 180, 21, "",                            #PB_Text_Center | #PB_Text_Border)
    
    ComboBoxGadget(#RESULT_COMBO_BOX,  210, 230,  40, 20)
    
    SetWindowColor(#MAIN_WINDOW, $FFFFFF)
    
    SetGadgetColor(#TRAFFIC_TEXT,  #PB_Gadget_BackColor, $FFFFFF)
    SetGadgetColor(#DAYS_TEXT,     #PB_Gadget_BackColor, $FFFFFF)
    SetGadgetColor(#RESULT_TEXT,   #PB_Gadget_BackColor, $FFFFFF)
    SetGadgetColor(#RESULT_STRING, #PB_Gadget_BackColor, $FFFFFF)
    
    AddGadgetItem(#TRAFFIC_COMBO_BOX, #UNITS_MB, "МБ")
    AddGadgetItem(#TRAFFIC_COMBO_BOX, #UNITS_GB, "ГБ")
    
    SetGadgetState(#TRAFFIC_COMBO_BOX, #UNITS_MB)
    
    AddGadgetItem(#RESULT_COMBO_BOX, #UNITS_MB, "МБ")
    AddGadgetItem(#RESULT_COMBO_BOX, #UNITS_GB, "ГБ")
    
    SetGadgetState(#RESULT_COMBO_BOX, #UNITS_MB) 
  EndIf
EndProcedure

OpenMainWindow()

Repeat
  
  event       = WaitWindowEvent()
  eventMenu   = EventMenu()
  eventGadget = EventGadget()
  eventWindow = EventWindow()
  eventType   = EventType()
  
  If eventWindow = #MAIN_WINDOW
    If event = #PB_Event_Menu
      If eventMenu = #ACTION_EXIT
        Break
      ElseIf eventMenu = #ACTION_ABOUT
        MessageRequester("О программе", "Контроль трафика 1.0" + #CR$ + #CR$ + "Автор: Салават Даутов" + #CR$ + #CR$ + "Дата создания: июль 2012 года", #MB_ICONINFORMATION)
      EndIf
    EndIf
    
    If event = #PB_Event_Gadget
      If eventGadget = #CALCULATE_BUTTON
        traffic.d = ValD(GetGadgetText(#TRAFFIC_STRING))
        days.d = ValD(GetGadgetText(#DAYS_STRING))
        
        If days <> 0
          If GetGadgetState(#TRAFFIC_COMBO_BOX) = #UNITS_GB
            traffic = traffic * 1024
          EndIf
          
          result.d = traffic / days
          
          If GetGadgetState(#RESULT_COMBO_BOX) = #UNITS_GB
            result = result / 1024
          EndIf
          
          SetGadgetText(#RESULT_STRING, StrD(result, 2))
        EndIf
      EndIf
    EndIf
  EndIf
Until event = #PB_Event_CloseWindow And eventWindow = #MAIN_WINDOW
