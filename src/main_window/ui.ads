with GWindows.Base;
with Gwindows.Menus;
with GWindows.Common_Controls;
with GWindows.Types;
with GWindows.Windows.Main;

package UI is

   -- Main menu
   package Main_Menu is

      procedure Init(Window : in out GWindows.Windows.Main.Main_Window_Type);
      
      procedure Menu_Select_Cb(Window : in out GWindows.Base.Base_Window_Type'Class;
                               Item   : in     Integer);

   end Main_Menu;
   
   -- Tab control
   type Dumpview_Tab_Control_Type is new GWindows.Common_Controls.Tab_Control_Type with private;
   function Adjust_Rect(Tab_Ctrl : Dumpview_Tab_Control_Type;
                        F_Larger : Integer := 0) 
                        return GWindows.Types.Rectangle_Type;
   
   -- Main window
   type Dumpview_Main_Type is new GWindows.Windows.Main.Main_Window_Type with private;
   type Dumpview_Main_Access is access all Dumpview_Main_Type;
   
   function Create return Dumpview_Main_Access;
   procedure Message_Loop;
   
private
   type Dumpview_Tab_Control_Type is new GWindows.Common_Controls.Tab_Control_Type with null record;
   
   type Dumpview_Main_Type is new GWindows.Windows.Main.Main_Window_Type with
      record
         null;
      end record;

end UI;
