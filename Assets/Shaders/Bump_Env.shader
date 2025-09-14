Shader "ACG/BumpEnvReflection"
{
    Properties
    {
        _Texture ("Diffuse Texture", 2D) = "white" {}
        _Normal ("Normal Texture", 2D) = "bump" {}
        _BumpRange ("Bump Amount", Range(0,10)) = 1
        _TextureBumpscale ("Bump Scale", Range(0,10)) = 1
        _Cube ("Reflection Cubemap", CUBE) = "" {}
        _ReflectStrength ("Reflection Strength", Range(0,1)) = 0.5
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _Texture;
        sampler2D _Normal;
        samplerCUBE _Cube;
        half _BumpRange;
        half _TextureBumpscale;
        half _ReflectStrength;

        struct Input
        {
            float2 uv_Texture;
            float2 uv_Normal;
            float3 worldRefl; // Needed for reflection
            INTERNAL_DATA
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Diffuse
            o.Albedo = tex2D(_Texture, IN.uv_Texture * _TextureBumpscale).rgb;

            // Normal with bump strength
            float3 normalTex = UnpackNormal(tex2D(_Normal, IN.uv_Normal * _TextureBumpscale));
            normalTex.xy *= _BumpRange;
            normalTex = normalize(normalTex);
            o.Normal = normalTex;

            // Reflection color (distorted by normal map)
            float3 reflCol = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb;

            // Blend reflection with diffuse
            o.Emission = reflCol * _ReflectStrength;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
