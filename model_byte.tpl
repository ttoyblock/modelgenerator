{{$exportModelName := .ModelName | FirstCharUpperPerUnderline}}

package {{.PackageName}}

import(
	"github.com/pkg/errors"
	"gorm.io/gorm"
)

type {{$exportModelName}} struct {
{{range .TableSchema}} {{.COLUMN_NAME | ExportColumn}} {{.DATA_TYPE | TypeConvertV3}} {{.COLUMN_NAME | GormTags}} // {{.COLUMN_COMMENT}}
{{end}}}

var Obj{{$exportModelName}} = {{$exportModelName}}{}

func (*{{$exportModelName}}) TableName() string {
	return "{{.TableName}}"
}

// -------------generate------------

// AddOne add one
func (*{{$exportModelName}}) AddOne(DB *gorm.DB,info *{{$exportModelName}}) (err error) {
	tx := DB.Create(info)
	return errors.WithStack(tx.Error)
}

{{if .HavePk}}
// DeleteByID delete one
func (*{{$exportModelName}}) DeleteByID(DB *gorm.DB, {{.PkColumnsSchema | ColumnAndType}}) (aff int64,err error) {
	tx := DB.Delete(&{{$exportModelName}}{}, {{.PkColumn}})
	return tx.RowsAffected, errors.WithStack(tx.Error)
}

// UpdateByID update non-zero fields
func (*{{$exportModelName}}) UpdateByID(DB *gorm.DB, info {{$exportModelName}}) (aff int64,err error) {
	tx := DB.Model({{$exportModelName}}{}).Where("id = ?", info.ID).Updates(info)
	return tx.RowsAffected, errors.WithStack(tx.Error)
}

// GetByID get one
func (*{{$exportModelName}}) GetByID(DB *gorm.DB, {{.PkColumnsSchema | ColumnAndType}}) (ret *{{$exportModelName}}, err error) {
	ret = &{{$exportModelName}}{}
	err = DB.Where("id = ?", {{.PkColumn}}).First(ret).Error
	err = errors.WithStack(err)
	return
}
{{end}}

// -------------generate------------