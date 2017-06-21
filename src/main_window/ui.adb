with GWindows.Application;
with GWindows.Drawing_Objects;
with GWindows.Windows;

with Gwindows.Menus; use Gwindows.Menus;
with GWindows.Base; use GWindows.Base;
with GWindows.Common_Controls; use GWindows.Common_Controls;
with GWindows.Edit_Boxes; use GWindows.Edit_Boxes;
with GWindows.Packing_Boxes; use GWindows.Packing_Boxes;
with GWindows.Windows.Main; use GWindows.Windows.Main;

with Constants; use Constants;

package body UI is

   -- Main menu package

   package body Main_Menu is

      -- Init
      procedure Init(Window : in out Main_Window_Type) is
         Main_Menu : Menu_Type := Create_Menu;
         File_Menu : Menu_Type := Create_Popup;
      begin
         Append_Item(File_Menu,"&Open",IDM_FILE_OPEN);
         Append_Separator(File_Menu);
         Append_Item(File_Menu,"&Exit",IDM_EXIT);
         Append_Menu(Main_Menu,"&File",File_Menu);
         Append_Item(Main_Menu,"A&bout",IDM_ABOUT);

         Window.Menu(Main_Menu);
         Window.On_Menu_Select_Handler(Menu_Select_Cb'Access);
      end Init;

      -- Menu_Select_Cb
      procedure Menu_Select_Cb(Window : in out Base_Window_Type'Class;
                               Item   : in     Integer) is
      begin
         case Item is

            when IDM_EXIT =>
               Window.Close;

            when others =>
               null;

         end case;
      end Menu_Select_Cb;

   end Main_Menu;

   -- Main window

   -- Global variables

   Dumpview_Main   : aliased Dumpview_Main_Type;
   Tab_Control_Box : Packing_Box_Type;
   Tab_Control     : Tab_Control_Type;

   Tab_Edit_Box    : Packing_Box_Type;
   Edit_Box        : Multi_Line_Edit_Box_Type;
   -- Init --

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
      Main_Menu.Init(Main_Window_Type(Dumpview_Main));

      -- Default tab control
      Tab_Control_Box.Create(Dumpview_Main,0,0,0,0);
      Tab_Control_Box.Dock(Fill);
      Tab_Control_Box.Fill_Width;
      Tab_Control_Box.Fill_Height;

      Tab_Control.Create(Tab_Control_Box,0,0,0,0);
      Tab_Control.Insert_Tab(0,"defalut");
      Tab_Control_Box.Pack;

      -- Pack items on the main window
      Dumpview_Main.Dock_Children;

      -- Edit box multiline

      Edit_Box.Create_Multi_Line(Tab_Control,"Test",0,20,Tab_Control.Width,Tab_Control.Height-20);

      return Dumpview_Main'Access;
   end Create;


   -- Message_Loop --

   procedure Message_Loop is
   begin
      GWindows.Application.Message_Loop;
   end Message_Loop;

end UI;
