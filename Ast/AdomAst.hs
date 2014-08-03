module Ast.AdomAst (
	ElemName,
	ElemType,
	ActivityElem(ActivityElem),
	ExtraElem(ExtraElem),
	TopLevelActivity(TopLevelActivity)
) where

type ElemName = String
type ElemType = String

data ExtraElem = ExtraElem ElemName ElemType
	deriving (Show)

data ActivityElem = ActivityElem ElemName
	deriving (Show)

data TopLevelActivity = TopLevelActivity ActivityElem [ExtraElem]