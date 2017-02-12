SELECT it.Name [Item]
	,it.Price
	,it.MinLevel
	,gt.Name AS [Forbidden Game Type]
FROM Items AS it
LEFT JOIN GameTypeForbiddenItems AS gtfi
ON gtfi.ItemId = it.Id
LEFT JOIN GameTypes as gt
ON gt.Id = gtfi.GameTypeId
ORDER BY gt.Name DESC, it.Name