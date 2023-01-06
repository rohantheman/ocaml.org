type metadata = {
  title : string;
  logo : string;
  background : string;
  theme : string;
  synopsis : string;
  url : string;
}
[@@deriving of_yaml]

type t = {
  title : string;
  slug : string;
  logo : string;
  background : string;
  theme : string;
  synopsis : string;
  url : string;
  body_md : string;
  body_html : string;
}
[@@deriving
  stable_record ~version:metadata ~remove:[ slug; body_md; body_html ],
    show { with_path = false }]

let of_metadata m = of_metadata m ~slug:(Utils.slugify m.title)

let all () =
  Utils.map_files
    (fun content ->
      let metadata, body_md = Utils.extract_metadata_body content in
      let metadata = Utils.decode_or_raise metadata_of_yaml metadata in
      let body_html = Omd.of_string body_md |> Omd.to_html in
      of_metadata metadata ~body_md ~body_html)
    "success_stories"

let template () =
  Format.asprintf
    {|
type t =
  { title : string
  ; slug : string
  ; logo : string
  ; background : string
  ; theme : string
  ; synopsis : string
  ; url : string
  ; body_md : string
  ; body_html : string
  }
  
let all = %a
|}
    (Fmt.brackets (Fmt.list pp ~sep:Fmt.semi))
    (all ())
