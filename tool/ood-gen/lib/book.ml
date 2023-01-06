type link = { description : string; uri : string }
[@@deriving of_yaml, show { with_path = false }]

type metadata = {
  title : string;
  description : string;
  authors : string list;
  language : string;
  published : string;
  cover : string;
  isbn : string option;
  links : link list;
  rating : int option;
  featured : bool;
}
[@@deriving of_yaml, show { with_path = false }]

type t = {
  title : string;
  slug : string;
  description : string;
  authors : string list;
  language : string;
  published : string;
  cover : string;
  isbn : string option;
  links : link list;
  rating : int option;
  featured : bool;
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
      let metadata, body = Utils.extract_metadata_body content in
      let metadata = Utils.decode_or_raise metadata_of_yaml metadata in
      let body_md = String.trim body in
      let body_html = Omd.of_string body |> Omd.to_html in
      of_metadata metadata ~body_md ~body_html)
    "books/"

let template () =
  Format.asprintf
    {|
type link = { description : string; uri : string }

type t = 
  { title : string
  ; slug : string
  ; description : string
  ; authors : string list
  ; language : string
  ; published : string
  ; cover : string
  ; isbn : string option
  ; links : link list
  ; rating : int option
  ; featured : bool
  ; body_md : string
  ; body_html : string
  }

let all = %a
|}
    (Fmt.brackets (Fmt.list pp ~sep:Fmt.semi))
    (all ())
