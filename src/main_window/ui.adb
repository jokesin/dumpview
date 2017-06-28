with Ada.Unchecked_Conversion;

with GWindows.Application;
with GWindows.Drawing_Objects;
with GWindows.Windows;

with Gwindows.Menus; use Gwindows.Menus;
with GWindows.Base; use GWindows.Base;
with GWindows.Common_Controls; use GWindows.Common_Controls;
with GWindows.Edit_Boxes; use GWindows.Edit_Boxes;
with GWindows.Packing_Boxes; use GWindows.Packing_Boxes;
with GWindows.Types; use GWindows.Types;
with GWindows.Windows.Main; use GWindows.Windows.Main;

with System; use System;

with Interfaces.C;

with UI.Callbacks; use UI.Callbacks;
with Constants; use Constants;

package body UI is

   package C renames Interfaces.C;

   -----------------------------
   -- COMMON IMPORT FUNCTIONS --
   -----------------------------

   function LoadLibrary(lpFileName: C.char_array) return GWindows.Types.Handle
        with Import, Convention => Stdcall, External_Name => "LoadLibraryA";

   function GetProcAddress(hModule    : GWindows.Types.Handle;
                           lpProcName : C.char_array) return Address
     with Import, Convention => Stdcall, External_Name => "GetProcAddress";


   ------------------------------
   -- NESTED SEPARATE PACKAGES --
   ------------------------------

   package body Dump_Tab_Controls is separate;

   ----------------------
   -- GLOBAL VARIABLES --
   ----------------------

   Dumpview_Main     : aliased Dumpview_Main_Type;
   Tab_Control_Box   : Packing_Box_Type;

   -----------------------
   -- PUBLIC PRIMITIVES --
   -----------------------

   -- Init_Menu

   procedure Init_Menu(Window : in out Main_Window_Type) is
      Main_Menu               : Menu_Type := Create_Menu;
      File_Menu               : Menu_Type := Create_Popup;
   begin
      Append_Item(File_Menu,"&Open",IDM_FILE_OPEN);
      Append_Separator(File_Menu);
      Append_Item(File_Menu,"&Exit",IDM_EXIT);
      Append_Menu(Main_Menu,"&File",File_Menu);
      Append_Item(Main_Menu,"A&bout",IDM_ABOUT);

      Window.Menu(Main_Menu);
      Window.On_Menu_Select_Handler(Menu_Select_Cb'Access);
   end Init_Menu;


   -- Create --

   function Create return Dumpview_Main_Access is
   begin

      Dumpview_Main.Create("dumpview",Width => 600,Height => 500);
      Dumpview_Main.Show;

      -- Set font
      declare
         Window_Font : GWindows.Drawing_Objects.Font_Type;
      begin
         Window_Font.Create_Stock_Font(GWindows.Drawing_Objects.Default_GUI);
         Dumpview_Main.Set_Font(Window_Font);
      end;

      -- Init menu
      Init_Menu(Main_Window_Type(Dumpview_Main));

      Tab_Control_Box.Create(Dumpview_Main,0,0,0,0);
      Tab_Control_Box.Dock(Fill);
      Tab_Control_Box.Fill_Width;
      Tab_Control_Box.Fill_Height;

      Dump_Tab_Controls.Create(Tab_Control_Box);
      -- Pack items on the main window
      Dumpview_Main.Dock_Children;

      -- Fill items now
      Dump_Tab_Controls.Get.Create_List_View;
      return Dumpview_Main'Access;
   end Create;


   -- Message_Loop --

   procedure Message_Loop is
   begin
      GWindows.Application.Message_Loop;
   end Message_Loop;

end UI;
