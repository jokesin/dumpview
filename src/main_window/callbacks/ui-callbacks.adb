with GWindows.Base; use GWindows.Base;
with Constants; use Constants;

package body UI.Callbacks is

   -- Menu_Select_Cb --

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

end UI.Callbacks;
