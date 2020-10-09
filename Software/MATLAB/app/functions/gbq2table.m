function mattable = gbq2table(tableResult)
%GBQ2TABLE Returns tableResults formatted into a structured MATLAB table
%object

%                 (c) 2020 MathWorks, Inc.

% Accessing Java Object from Handle
tableresults = tableResult.Handle;

% Returns total number of rows, greater than number of rows in a given page
nRows = tableresults.getTotalRows;

% Accessing schema from tableResults
schema = tableresults.getSchema;

% Schema contains field names and types for every field value or table
% column
fields = schema.getFields.toArray;

% Iterating through number of fields (or number of columns) to get Column
% name and Datatype for that column

% LEGACY SQL TYPE : (https://cloud.google.com/bigquery/data-types#legacy_sql_data_types)
%
% Supported : STRING, BYTES, INTEGER, FLOAT, BOOLEAN, NUMERIC, TIMESTAMP
% UnSupported : RECORD, DATE, TIME, DATETIME (casted as String)

j = 0;
i = 0;
skipcol = [];
while i < numel(fields)
    i = i+1;
    fieldobj = fields(i);
    mode = fieldobj.getMode;
    if ~isequal(string(mode.toString),"REPEATED")
        j = j+1;
        switch char(fieldobj.getType)
            case 'STRING'
                variableTypes{j} = 'string' ; %#ok<*AGROW>
                schemaTypes{j} = 'string' ;
                variableNames{j} = char(fieldobj.getName);
            case 'INTEGER'
                variableTypes{j} = 'int64' ;
                schemaTypes{j} = 'integer' ;
                variableNames{j} = char(fieldobj.getName);
            case 'BOOLEAN'
                variableTypes{j} = 'logical' ;
                schemaTypes{j} = 'boolean' ;
                variableNames{j} = char(fieldobj.getName);
            case 'FLOAT'
                variableTypes{j} = 'double' ;
                schemaTypes{j} = 'float' ;
                variableNames{j} = char(fieldobj.getName);
            case 'BYTES'
                variableTypes{j} = 'int8' ;
                schemaTypes{j} = 'bytes' ;
                variableNames{j} = char(fieldobj.getName);
            case 'TIMESTAMP'
                variableTypes{j} = 'datetime' ;
                schemaTypes{j} = 'timestamp' ;
                variableNames{j} = char(fieldobj.getName);
            case 'DATE'
                variableTypes{j} = 'datetime' ;
                schemaTypes{j} = 'date' ;
                variableNames{j} = char(fieldobj.getName);
            case 'TIME'
                variableTypes{j} = 'duration' ;
                schemaTypes{j} = 'time' ;
                variableNames{j} = char(fieldobj.getName);               
            case 'NUMERIC'
                variableTypes{j} = 'double' ;
                schemaTypes{j} = 'numeric' ;
                variableNames{j} = char(fieldobj.getName);
            case 'RECORD'
                % unsupported column due to RECORD Datatype
                skipcol = [skipcol , i];
                j = j-1;
            case 'GEOGRAPHY'
                % unsupported column due to RECORD Datatype
                skipcol = [skipcol , i];      
                j = j-1;
            otherwise                
                % DATETIME
                variableTypes{j} = 'string';
                schemaTypes{j} = 'string' ;
                variableNames{j} = char(fieldobj.getName);
        end
    else
        skipcol = [skipcol , i];
        
    end
end

% Constructing MATLAB table of size [nRows numel(fields)]
% VariableTypes will be decided by schema.field.type
% VariableNames will be decided by schema.field.name

if j > 0
% Table definition
mattable = table('Size',[nRows j],'VariableTypes',variableTypes);
mattable.Properties.VariableNames = variableNames;
if j < i
    warning('Some columns have been removed due to unsupported mode or datatype');
end
% Table construction completed
%% Unpacking values and assigning to MATLAB table

% Initializing Row counter
rowcount = 0;

% Iterating through rows
values = tableresults.iterateAll;

% Iterator object for while loop
valueiterator = values.iterator;

% Check for next available iteration
% Check Java Performance
% Graph for Table size linearly
% Warning - Best practice - batch job

while valueiterator.hasNext
    
    k = 0; %flag
    % Row counter for validation
    rowcount = rowcount + 1;
    
    % Extract Column values for current Row
    currentrowval = valueiterator.next;
    
    % Convert column values to array of Objects
    currentcolvals =  currentrowval.toArray;
    
    % Delete objects pertaining to indices/columns to be skipped due to
    % unsupported mode or datatype
    currentcolvals(skipcol)=[];
    i=1;
    % Iterating through columns
    while i <= numel(currentcolvals)
        
        % Checking if col is skipped 
        if ~isempty(currentcolvals(i))
            
            % Accessing value that needs to be assigned to
            % mattable(rowcount,i) if col exists and not skipped
            currentcolval =  currentcolvals(i).getValue;
            
            % Checking if col value extracted is null
            if ~isempty(currentcolval)
                
                % standardizing missing value (optional)
                % currentcolval = standardizeMissing(currentcolval,variableTypes{i});
            
            k = k+1;
            % Checking for Datatype for Table Variable and applying correct
            % conversions
            switch schemaTypes{k}
                case 'string'
                    mattable{rowcount,k} = string(currentcolval);
                    
                case 'time'
                    mattable{rowcount,k} = duration(currentcolval);   
                    
                case 'integer'
                    mattable{rowcount,k} = int64(str2double(currentcolval));
                                        
                case 'boolean'
                    currentcolval =  currentcolvals(i).getBooleanValue;
                    mattable{rowcount,k} = logical(currentcolval);
                                      
                case 'float'
                    mattable{rowcount,k} = str2double(string(currentcolval));
                    
                case 'numeric'
                    mattable{rowcount,k} = str2double(string(currentcolval));   
                    
                case 'bytes'
                    mattable{rowcount,k} = int8(currentcolval);
                    
                case 'timestamp'
                    mattable{rowcount,k} =  datetime(str2double(currentcolval),'ConvertFrom', 'posixtime');
                  
                case 'date'
                    mattable{rowcount,k} =  datetime(currentcolval);
                otherwise
                    mattable{rowcount,k} = string(currentcolval);
                    
            end % switch (assignment complete)
            end % no assignment if value returned is null 
        else
           % warning('Skipping col due to unsupported mode or format ');
           
        end % if checking columns to be switched
        i = i+1;
    end % for loop for column fields for every row  (next row)
    
end % Value iterator for TableResult (iterator exhausted)

else
    if i > 0
        warning('no data to return due to unsupported formats or modes');
        mattable = [];
    end
end

end %function
