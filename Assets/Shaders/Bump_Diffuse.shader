Shader "ACG/BumpDiffuse"
{
    Properties
    {
        _Texture ("Diffuse Texture", 2D) = "white" {}
        _Normal ("Normal Texture", 2D) = "bump" {}
        _BumpRange ("Bump Amount", Range(0,10)) = 1
        _TextureBumpscale ("Bump scale", Range(0,10)) = 1
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _Texture;
        sampler2D _Normal;
        half _BumpRange;
        half _TextureBumpscale;

        struct Input
        {
            float2 uv_Texture;
            float2 uv_Normal;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Diffuse color
            o.Albedo = tex2D(_Texture, IN.uv_Texture * _TextureBumpscale).rgb;

            // Normal with adjustable bump
            float3 normalTex = UnpackNormal(tex2D(_Normal, IN.uv_Normal * _TextureBumpscale));

            // Scale X and Y, then renormalize
            normalTex.xy *= _BumpRange;
            normalTex = normalize(normalTex);

            o.Normal = normalTex;
        }
        ENDCG
    }
}
