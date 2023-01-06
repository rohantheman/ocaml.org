type metadata = {
  title : string;
  description : string;
  date : string;
  tags : string list;
  authors : string list option;
}
[@@deriving of_yaml]

type t = {
  title : string;
  description : string;
  date : string;
  slug : string;
  tags : string list;
  body_html : string;
}
[@@deriving
  stable_record ~version:metadata ~add:[ authors ] ~remove:[ slug; body_html ],
    show { with_path = false }]

let all () =
  Utils.map_files_with_names
    (fun (fname, content) ->
      let slug = Filename.basename (Filename.remove_extension fname) in
      let metadata, body = Utils.extract_metadata_body content in
      let metadata = Utils.decode_or_raise metadata_of_yaml metadata in
      let body_html =
        Omd.to_html (Hilite.Md.transform (Omd.of_string (String.trim body)))
      in
      of_metadata metadata ~slug ~body_html)
    "news/*/*.md"
  |> List.sort (fun a b -> String.compare b.date a.date)

let template () =
  Format.asprintf
    {|
type t =
  { title : string
  ; slug : string
  ; description : string
  ; date : string
  ; tags : string list
  ; body_html : string
  }
  
let all = %a
|}
    (Fmt.brackets (Fmt.list pp ~sep:Fmt.semi))
    (all ())
