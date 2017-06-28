with GWindows.Base;
with Gwindows.Menus;
with GWindows.Common_Controls;
with GWindows.Packing_Boxes;
with GWindows.Types;
with GWindows.Windows.Main;

package UI is

   -- Main window
   type Dumpview_Main_Type is new GWindows.Windows.Main.Main_Window_Type with private;
   type Dumpview_Main_Access is access all Dumpview_Main_Type;
   
   function Create return Dumpview_Main_Access;
   procedure Message_Loop;
   
private
   
   -- Main menu
   procedure Init_Menu(Window : in out GWindows.Windows.Main.Main_Window_Type);
      
   -- Dump_Tab_Controls
   package Dump_Tab_Controls is      
      type Dump_Tab_Control_Type is new GWindows.Common_Controls.Tab_Control_Type with private;
      type Dump_Tab_Control is access all Dump_Tab_Control_Type;
      
      procedure Create(Tab_Ctrl     : in out Dump_Tab_Control_Type;
                       Tab_Ctrl_Box : in out GWindows.Packing_Boxes.Packing_Box_Type);
      procedure Create_List_View(This : in out Dump_Tab_Control_Type);
      
   private
      
      type Dump_Tab_Control_Type is new GWindows.Common_Controls.Tab_Control_Type with
         record
            List_View : GWindows.Common_Controls.List_View_Control_Type;
         end record;
      
      function Get_Delta_Rect(This : Dump_Tab_Control_Type)
                              return GWindows.Types.Rectangle_Type;
      
      
   end Dump_Tab_Controls;
   
   -- Dumpview_Main_Type
   
   type Dumpview_Main_Type is new GWindows.Windows.Main.Main_Window_Type with
      record
         Tab_Control : Dump_Tab_Controls.Dump_Tab_Control_Type;
      end record;

end UI;
