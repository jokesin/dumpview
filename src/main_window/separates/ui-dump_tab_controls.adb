with Ada.Characters.Conversions; use Ada.Characters.Conversions;

with Strings_Edit.Integers;

separate (UI)

package body Dump_Tab_Controls is
   
   ----------------------
   -- GLOBAL VARIABLES --
   ----------------------
   
   
   
   ------------------------------------
   -- CLOSE PRIVATE PRIMITIVES DECLS --
   ------------------------------------
   
   -----------------------
   -- PUBLIC PRIMITIVES --
   -----------------------
   
   -- Create
   
   procedure Create(Tab_Ctrl     : in out Dump_Tab_Control_Type;
                    Tab_Ctrl_Box : in out GWindows.Packing_Boxes.Packing_Box_Type) is  
   begin      
      Tab_Ctrl.Create(Tab_Ctrl_Box,0,0,0,0);
      Tab_Ctrl.Insert_Tab(0,"default");
      Tab_Ctrl_Box.Pack;
   end Create;
         
   -- Create_List_View
   
   procedure Create_List_View(This : in out Dump_Tab_Control_Type)
   is
      Tab_Rect : Rectangle_Type := This.Get_Delta_Rect;
      H:Integer := This.Height;
   begin
      This.List_View.Create(This,0,Tab_Rect.Top,This.Width, This.Height-Tab_Rect.Top,
                            View => Report_View);
      This.List_View.Insert_Column("offset",0,60);
      
      for K in 0..15 loop         
         This.List_View.Insert_Column(To_Wide_String(Strings_Edit.Integers.Image(K,16)),K+1,25);
      end loop;
      
      This.List_View.Insert_Column("ascii",17,100);
      
      This.List_View.Insert_Item("item 1",0);
      This.List_View.Set_Sub_Item("00",0,1);
      This.List_View.Set_Sub_Item("00",0,2);

      This.List_View.Insert_Item("item 2",1);
      This.List_View.Set_Sub_Item("subitem 2 1",1,1);
      This.List_View.Set_Sub_Item("subitem 2 2",1,2);

      This.List_View.Insert_Item("item 3",2);
      This.List_View.Set_Sub_Item("subitem 3 1",2,1);
      This.List_View.Set_Sub_Item("subitem 3 2",2,2);
   end Create_List_View;
   
   -------------------
   -- PRIVATE
   -------------------
   
   function Get_Delta_Rect(This : Dump_Tab_Control_Type)
                           return GWindows.Types.Rectangle_Type is

      type SendMessage_Type is access function
        (hWnd : in GWindows.Types.Handle;
         Msg  : in C.unsigned;
         wParam : in GWindows.Types.Wparam;
         lParam : in GWindows.Types.Lparam)
         return GWindows.Types.Lresult
        with Convention => Stdcall;
      function SendMessage is new Ada.Unchecked_Conversion(Address, SendMessage_Type);

      type PRECT is access all GWindows.Types.Rectangle_Type
        with Convention => C;

      type GetWindowRect_Type is access function
        (hWnd   : in GWindows.Types.Handle;
         lpRect : PRECT)
         return Boolean
        with Convention => Stdcall;
      function GetWindowRect is new Ada.Unchecked_Conversion(Address, GetWindowRect_Type);

      User32_Dll : GWindows.Types.Handle := LoadLibrary(C.To_C("user32.dll"));
      SendMessage_Pointer : Address := GetProcAddress(User32_Dll,C.To_C("SendMessageA"));
      Tab_Rect : Rectangle_Type := (others => 0);
   begin
      if SendMessage_Pointer /= Null_Address then
         declare
            function To_lParam is new Ada.Unchecked_Conversion(Address, GWindows.Types.Lparam);
            Lresult : GWindows.Types.Lresult:= SendMessage(SendMessage_Pointer)(This.Handle, TCM_ADJUSTRECT,0,
                                                                                To_lParam(Tab_Rect'Address));
         begin
            null;
         end;
      end if;
      return Tab_Rect;
   end Get_Delta_Rect;
      
   -------------------
   -- CLOSE PRIVATE
   -------------------
   
   
end Dump_Tab_Controls;
