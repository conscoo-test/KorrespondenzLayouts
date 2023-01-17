codeunit 5272732 "lbt cl Option Lookup"
{
    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", 'OnAutoCompleteOptionLookupTypeCase', '', false, false)]
    local procedure OnAutoCompleteOptionLookupTypeCase(var Sender: Record "Option Lookup Buffer"; LookupType: Enum "Option Lookup Type"; var OptionType: Text[30]; var IsHandled: Boolean);
    var
        LongtextSystemId: Record "lbt clPSLongtextSystemId";
    begin
        case LookupType of
            LookupType::"lbt cl Longtext":
                begin
                    OptionType := Format(LongtextSystemId.Position);
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", 'OnFillBufferLookupTypeCase', '', false, false)]
    local procedure OnFillBufferLookupTypeCase(var Sender: Record "Option Lookup Buffer"; LookupType: Enum "Option Lookup Type"; var IsHandled: Boolean; var TableNo: Integer; var FieldNo: Integer; var RelationFieldNo: Integer);
    var
        LongtextSystemId: Record "lbt clPSLongtextSystemId";
    begin
        case LookupType of
            LookupType::"lbt cl Longtext":
                begin
                    TableNo := Database::"lbt clPSLongtextSystemId";
                    FieldNo := LongtextSystemId.FieldNo(Position);
                    RelationFieldNo := 0;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", 'OnBeforeIncludeOption', '', false, false)]
    local procedure OnBeforeIncludeOption(OptionLookupBuffer: Record "Option Lookup Buffer"; LookupType: Option; Option: Integer; var Handled: Boolean; var Result: Boolean; RecRef: RecordRef);
    var
        LongtextSystemId: Record "lbt clPSLongtextSystemId";
    begin
        case LookupType of
            "Option Lookup Type"::"lbt cl Longtext".AsInteger():
                begin
                    case Option of
                        LongtextSystemId.Position::EditorFooter.AsInteger(), LongtextSystemId.Position::EditorHeader.AsInteger():
                            Result := true;
                    end;
                    Handled := true;
                end;
        end;
    end;

}