SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create function dbo.f_GetPositionOptions
	(
	@Position int,
	@MaxPosition int
	) returns varchar(4000)
as
begin
	declare @Result varchar(4000)
	declare @i int

	select @Result = '', @i = 1

	while @i <= @MaxPosition
	begin
		if @i = @Position
		begin
			select @Result = @Result + '<OPTION value=' + convert(varchar, @i) + ' selected>' + convert(varchar, @i) + '</OPTION>'
		end
		else
		begin
			select @Result = @Result + '<OPTION value=' + convert(varchar, @i) + '>' + convert(varchar, @i) + '</OPTION>'
		end

		select @i = @i + 1
	end

	return @Result
end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

