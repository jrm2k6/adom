module Ast.AdomAst (
	ElemName,
	ElemType,
	ActivityElem(ActivityElem)
) where

type ElemName = String
type ElemType = String

data ActivityElem = ActivityElem ElemName
	deriving (Show)