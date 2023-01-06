type metadata = {
  name : string;
  description : string;
  logo : string option;
  url : string;
  locations : string list;
  consortium : bool;
  featured : bool;
}
[@@deriving of_yaml]

type t = {
  name : string;
  slug : string;
  description : string;
  logo : string option;
  url : string;
  locations : string list;
  consortium : bool;
  featured : bool;
  body_md : string;
  body_html : string;
}
[@@deriving
  stable_record ~version:metadata ~remove:[ slug; body_md; body_html ],
    show { with_path = false }]

let of_metadata m = of_metadata m ~slug:(Utils.slugify m.name)

let all () =
  Utils.map_files
    (fun content ->
      let metadata, body_md = Utils.extract_metadata_body content in
      let metadata = Utils.decode_or_raise metadata_of_yaml metadata in
      let body_html = Omd.of_string body_md |> Omd.to_html in
      of_metadata metadata ~body_md ~body_html)
    "industrial_users"

let template () =
  Format.asprintf
    {|
type t =
  { name : string
  ; slug : string
  ; description : string
  ; logo : string option
  ; url : string
  ; locations : string list
  ; consortium : bool
  ; featured : bool
  ; body_md : string
  ; body_html : string
  }
  
let all = %a
|}
    (Fmt.brackets (Fmt.list pp ~sep:Fmt.semi))
    (all ())
