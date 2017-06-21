with UI; use UI;

procedure Main is

   pragma Linker_Options("-mwindows");

   Main_Window : Dumpview_Main_Access := Create;
begin
   Message_Loop;
end Main;
