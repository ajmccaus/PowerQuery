// this code is to create excel column letters (A, B, C, AA, AB, etc) from an excel worksheet that has been transposed, 
// so that the excel columns are in the rows of the transposed table. This can be useful when working with an excel spreadsheet
// with 10's or 100's of columns, up to about 675 columns (column ZZ)

let
    Source = #"EDF Data",
    #"Added Index" = Table.AddIndexColumn(Source, "Index", 1, 1, Int64.Type),
    #"Added Custom" = 
    Table.AddColumn(
      #"Added Index", "Column", 
      // If the index is higher than 26 (Z) then add a leading letter
      each if [Index] < 26 then
      // start at B, since the first transposed column was used as the column headers
        Character.FromNumber( 65 + [Index] )
      else
        Character.FromNumber( 64 + Number.RoundDown( [Index] / 26 ) )
        & Character.FromNumber( 65 + [Index] - 26 * Number.RoundDown( [Index] / 26 ) )
    )
in
    #"Added Custom"
