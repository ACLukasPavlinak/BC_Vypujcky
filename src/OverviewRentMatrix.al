page 50104 OverviewRentMatrix
{
    Caption = 'Overview Rent Matrix';
    PageType = ListPart;
    SourceTable = "OverviewRentTab";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;
                field("Dev\Emp"; Rec.DevName)
                {
                    CaptionClass = 'Dev\Emp';
                    ApplicationArea = Planning;
                    Editable = false;
                }

                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[1];
                    Visible = Field1Visible;
                    BlankZero = true;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[2];
                    Visible = Field2Visible;
                    BlankZero = true;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[3];
                    Visible = Field3Visible;
                    BlankZero = true;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[4];
                    Visible = Field4Visible;
                    BlankZero = true;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[5];
                    Visible = Field5Visible;
                    BlankZero = true;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[6];
                    Visible = Field6Visible;
                    BlankZero = true;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[7];
                    Visible = Field7Visible;
                    BlankZero = true;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[8];
                    Visible = Field8Visible;
                    BlankZero = true;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[9];
                    Visible = Field9Visible;
                    BlankZero = true;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[10];
                    Visible = Field10Visible;
                    BlankZero = true;
                }
            }
        }
    }

    trigger OnInit()
    begin
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;

        SetEmp();


        Field1Visible := MATRIX_CaptionSet[1] <> '';
        Field2Visible := MATRIX_CaptionSet[2] <> '';
        Field3Visible := MATRIX_CaptionSet[3] <> '';
        Field4Visible := MATRIX_CaptionSet[4] <> '';
        Field5Visible := MATRIX_CaptionSet[5] <> '';
        Field6Visible := MATRIX_CaptionSet[6] <> '';
        Field7Visible := MATRIX_CaptionSet[7] <> '';
        Field8Visible := MATRIX_CaptionSet[8] <> '';
        Field9Visible := MATRIX_CaptionSet[9] <> '';
        Field10Visible := MATRIX_CaptionSet[10] <> '';
    end;

    var
        MATRIX_CaptionSet: array[10] of Text[32];
        MATRIX_CellData: array[32] of Decimal;
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;

    procedure SetEmp()
    var
        emp: Record Employee;
        dev: Record DevTab;
        OVDev: Record OverviewRentTab;
        Caption: Text[32];
        i: Integer;
    begin
        while dev.Name = '' do begin
            dev.Next();
        end;

        OVDev.DeleteAll(true);

        i := 1;

        OVDev.Init();
        OVDev.PK := i;
        OVDev.DevName := dev.Name;
        OVDev.Insert();
        dev.Next();

        while OVDev.DevName <> dev.Name do begin
            i := i + 1;
            OVDev.PK := i;
            OVDev.DevName := dev.Name;
            OVDev.Insert();
            dev.Next();
        end;


        while emp."First Name" = '' do begin
            emp.Next();
        end;

        MATRIX_CaptionSet[1] := emp.FullName();
        emp.Next();

        for i := 2 to 10 do begin
            if MATRIX_CaptionSet[i - 1] <> emp.FullName() then begin
                MATRIX_CaptionSet[i] := emp.FullName();
                emp.Next();
            end else begin
                break;
            end;

        end;
    end;

    trigger OnAfterGetRecord()
    var
        rents: Record RentDev;
        i, x : Integer;
    begin
        rents.Next();
        for i := 1 to 10 do begin
            MATRIX_CellData[i] := 0;
        end;

        for i := 1 to rents.Count do begin
            if rents.DevName = Rec.DevName then begin
                for x := 1 to 10 do begin
                    if (rents.EmpName = MATRIX_CaptionSet[x]) and (rents.Status <> rents.Status::Vraceno) then MATRIX_CellData[x] := MATRIX_CellData[x] + 1;
                end;
            end;
            rents.Next();
        end;
    end;
}